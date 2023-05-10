import 'package:baseservice/models/authen_model.dart';
import 'package:baseservice/states/create_new_account.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:baseservice/widgets/widget_button.dart';
import 'package:baseservice/widgets/widget_form.dart';
import 'package:baseservice/widgets/widget_icon_button.dart';
import 'package:baseservice/widgets/widget_image.dart';
import 'package:baseservice/widgets/widget_text.dart';
import 'package:baseservice/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());
  TextEditingController idCard = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: AppConstant().imageBox(),
        child: ListView(
          children: [
            head(),
            userForm(),
            passForm(),
            loginButton(),
            createNewAccountButton(),
          ],
        ),
      ),
    );
  }

  WidgetTextButton createNewAccountButton() {
    return WidgetTextButton(
            label: 'Create New Account',
            pressFunc: () {
              Get.to(const CreateNewAccount());
            },
            color: Colors.pink,
          );
  }

  Row loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WidgetButton(
                label: 'Login',
                pressFunc: () {
                  if ((idCard.text.isEmpty) || (password.text.isEmpty)) {
                    AppSnackBar(
                            title: 'Have Space ?',
                            message: 'Please Fill Every Blank')
                        .errorSnackBar();
                  } else if (idCard.text.length != 13) {
                    AppSnackBar(
                            title: 'Id Card 13 digi',
                            message: 'Please Fill Id card 13 digi')
                        .errorSnackBar();
                  } else {
                    AuthenModel authenModel = AuthenModel(
                        idcard: idCard.text, password: password.text);
                    AppService().processCheckAuthen(authenModel: authenModel);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row passForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          print('redEye --> ${appController.redEye.value}');
          return WidgetForm(
            textEditingController: password,
            hint: 'Password :',
            obsecu: appController.redEye.value,
            suffixWidget: WidgetIconButton(
              iconData: appController.redEye.value
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
              pressFunc: () {
                appController.redEye.value = !appController.redEye.value;
              },
            ),
          );
        }),
      ],
    );
  }

  Row userForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          hint: 'IDcard :',
          suffixWidget: const Icon(Icons.card_membership),
          textInputType: TextInputType.number,
          textEditingController: idCard,
          maxlength: 13,
        ),
      ],
    );
  }

  Row head() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: 250,
          child: Row(
            children: [
              const WidgetImage(
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 8,
              ),
              WidgetText(
                data: AppConstant.appName,
                textStyle: AppConstant()
                    .h1Style(size: 28, color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
