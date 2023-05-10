import 'package:baseservice/models/authen_model.dart';
import 'package:baseservice/models/create_new_account_model.dart';
import 'package:baseservice/models/result_authen_model.dart';
import 'package:baseservice/models/result_model.dart';
import 'package:baseservice/models/transection_model.dart';
import 'package:baseservice/states/main_home.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppService {
  AppController controller = Get.put(AppController());

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
