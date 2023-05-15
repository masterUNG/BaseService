import 'package:baseservice/models/authen_model.dart';
import 'package:baseservice/models/chat_model.dart';
import 'package:baseservice/models/create_new_account_model.dart';
import 'package:baseservice/models/id_model.dart';
import 'package:baseservice/models/result_authen_model.dart';
import 'package:baseservice/models/result_model.dart';
import 'package:baseservice/models/result_pin_code_model.dart';
import 'package:baseservice/models/transection_model.dart';
import 'package:baseservice/states/main_home.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppService {
  AppController controller = Get.put(AppController());

  Future<void> readChat() async {
    FirebaseFirestore.instance.collection('chat').orderBy('timestamp')
    .snapshots().listen((event) {
      if (controller.chatModels.isNotEmpty) {
        controller.chatModels.clear();
      }

      for (var element in event.docs) {
        ChatModel chatModel = ChatModel.fromMap(element.data());
        controller.chatModels.add(chatModel);
      }
    });
  }

  Future<void> insertDataToFirebase({required String message}) async {
    var user = FirebaseAuth.instance.currentUser;

    ChatModel chatModel = ChatModel(
        message: message,
        uid: user!.uid,
        timestamp: Timestamp.fromDate(DateTime.now()));

    print('chatModel ----> ${chatModel.toMap()}');

    await FirebaseFirestore.instance
        .collection('chat')
        .doc()
        .set(chatModel.toMap())
        .then((value) {
      print('Success');
    });
  }

  Future<void> checkAuthenFirebase() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      print('event --> $event');
      if (event == null) {
        await FirebaseAuth.instance.signInAnonymously().then((value) {
          String uid = value.user!.uid;
          print('uid ---> $uid');
        });
      }
    });
  }

  Future<void> createOtp({
    required ResultAuthenModel resultAuthenModel,
    // required String pinCode,
    // required String initialPage,
  }) async {
    String urlApi = 'http://115.31.144.227:3009/api/user/otpSend';

    Map<String, dynamic> map = {};
    map['id'] = resultAuthenModel.userData;

    map['id'] = '3102001256837'; // โกงกำหนดเพือ Training

    print('map at checkOtp ---> $map');

    IdModel idModel = IdModel.fromMap(map);

    try {
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      await dio.post(urlApi, data: idModel.toJson()).then((value) {
        print('value at checkOtp --> $value');

        var body = value.data['body'];
        var result = body['result'];
        ResultPinCodeModel resultPinCodeModel =
            ResultPinCodeModel.fromMap(result);
        print('resultPincodeModel ---> ${resultPinCodeModel.toMap()}');

        controller.resultPinCodeModels.add(resultPinCodeModel);

        // if (pinCode == resultPinCodeModel.ref_code) {
        //   // PinCode True

        //   Get.offAllNamed(initialPage);
        // } else {
        //   AppSnackBar(title: 'PinCode False', message: 'Please Try Again')
        //       .errorSnackBar();
        // }
      });
    } on Exception catch (e) {
      AppSnackBar(title: 'Id False', message: 'Please Check Id')
          .errorSnackBar();
    }
  }

  String findTranTypeCode({required String tranTypecodex}) {
    String typcodeName = '';
    if (tranTypecodex == "B") {
      typcodeName = "BUY";
    } else if (tranTypecodex == "S") {
      typcodeName = "SELL";
    } else if (tranTypecodex == "SO") {
      typcodeName = "Switch Out";
    } else if (tranTypecodex == "SI") {
      typcodeName = "Switch In";
    } else if (tranTypecodex == "TI") {
      typcodeName = "Trans In";
    } else if (tranTypecodex == "TO") {
      typcodeName = "Trans Out";
    }
    return typcodeName;
  }

  String cutWord(
      {required String string, required int start, required int end}) {
    String result = string;

    if (end < result.length) {
      result = result.substring(start, end);
    }

    return result;
  }

  double? checkDouble({required var testDouble}) {
    return testDouble is int ? testDouble.toDouble() : testDouble;
  }

  Future<void> readTransection(
      {required ResultAuthenModel resultAuthenModel}) async {
    //Spicial
    ResultAuthenModel model = resultAuthenModel;
    Map<String, dynamic> map = model.toMap();
    map['USERID'] = '3760500954079';
    model = ResultAuthenModel.fromMap(map);

    String urlApi =
        'https://wr.wealthrepublic.co.th:3009/api/wr/transaction/${model.USERID}?fromDate=${changeTimeToString(dateTime: controller.startDateTimes.last, format: "yyyy-MM-dd")}&toDate=${changeTimeToString(dateTime: controller.endDateTimes.last, format: "yyyy-MM-dd")}';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ${model.token}';

    await dio.get(urlApi).then((value) {
      print('statusCode at readTransection -----> ${value.statusCode}');

      if (value.statusCode == 200) {
        var result = value.data['result'];

        if (controller.transectionModels.isNotEmpty) {
          controller.transectionModels.clear();
        }

        for (var element in result) {
          TransectionModel transectionModel = TransectionModel.fromMap(element);
          controller.transectionModels.add(transectionModel);
        }
      }
    });
  }

  String changeTimeToString({required DateTime dateTime, String? format}) {
    DateFormat dateFormat = DateFormat(format ?? 'dd-MM-yyyy');
    return dateFormat.format(dateTime);
  }

  Future<void> processCheckAuthen({required AuthenModel authenModel}) async {
    print('model ---> ${authenModel.toJson()}');

    try {
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      await dio
          .post(AppConstant.urlApiAuthen, data: authenModel.toJson())
          .then((value) {
        print('status code ---> ${value.statusCode}');

        if (value.statusCode == 200) {
          //Authen Success

          ResultAuthenModel resultAuthenModel =
              ResultAuthenModel.fromMap(value.data);
          print('resultMOdel ---> ${resultAuthenModel.toMap()}');

          Get.offAll(MainHome(resultAuthenModel: resultAuthenModel));
        }
      });
    } on Exception catch (e) {
      AppSnackBar(title: 'Authen False', message: 'Please Try again')
          .errorSnackBar();
    }
  }

  Future<void> processCreateNewAccount(
      {required CreateNewAccountModel createNewAccountModel}) async {
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';

    await dio
        .post(AppConstant.urlApiCreateNewAccount,
            data: createNewAccountModel.toJson())
        .then((value) {
      print('statusCode ---> ${value.statusCode}');
      if (value.statusCode == 200) {
        var result = value.data;
        // print('result at processCreate ---> $value');

        for (var element in result) {
          ResultModel resultModel = ResultModel.fromMap(element);
          print('resultModel --> ${resultModel.toMap()}');

          if (resultModel.result.toString() == 'User Inserted') {
            //success
            Get.back();
            AppSnackBar(
                    title: 'Create New Account Success',
                    message: 'Thankyou Create Account')
                .normalSnackbar();
          } else {
            AppSnackBar(title: 'Cannot Create', message: resultModel.result)
                .errorSnackBar();
          }
        }
      } else {
        AppSnackBar(title: 'Cannot Create', message: 'Please Try Again')
            .errorSnackBar();
      }
    });
  }
}
