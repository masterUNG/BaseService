import 'package:baseservice/models/authen_model.dart';
import 'package:baseservice/models/create_new_account_model.dart';
import 'package:baseservice/models/result_authen_model.dart';
import 'package:baseservice/models/result_model.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppService {
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
