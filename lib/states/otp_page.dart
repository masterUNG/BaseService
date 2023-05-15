// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:baseservice/models/result_authen_model.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_service.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    Key? key,
    required this.resultAuthenModel,
    required this.initialPage,
  }) : super(key: key);

  final ResultAuthenModel resultAuthenModel;
  final String initialPage;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    super.initState();
    AppService().createOtp(resultAuthenModel: widget.resultAuthenModel);
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              'resultPinCodeModel ---> ${appController.resultPinCodeModels.length}');

          if (appController.resultPinCodeModels.isNotEmpty) {
            print(
                'resultPinCodeModel ---> ${appController.resultPinCodeModels.last}');
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(
                  fieldStyle: FieldStyle.box,
                  width: 250,
                  length: 6,
                  onCompleted: (value) {
                    print('onComplete Work ---> ${value.toString()}');

                    if (value.toString() ==
                        appController.resultPinCodeModels.last.ref_code) {
                      Get.offAllNamed(widget.initialPage);
                    } else {
                      AppSnackBar(
                              title: 'Pin Code False',
                              message: 'Please Tru Aganin')
                          .errorSnackBar();
                    }
                  },
                  onChanged: (value) {},
                ),
              ],
            ),
          );
        });
  }
}
