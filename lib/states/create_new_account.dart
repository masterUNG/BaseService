import 'package:baseservice/models/create_new_account_model.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:baseservice/widgets/widget_button.dart';
import 'package:baseservice/widgets/widget_form.dart';
import 'package:baseservice/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController idCard = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firsName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          data: 'Create New Account',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Phone Number :'),
                textInputType: TextInputType.phone,
                maxlength: 10,
                textEditingController: phoneNumber,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'ID card :'),
                textInputType: TextInputType.number,
                maxlength: 13,
                textEditingController: idCard,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Email :'),
                textInputType: TextInputType.emailAddress,
                textEditingController: email,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Password :'),
                textEditingController: password,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'FirstName :'),
                textEditingController: firsName,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'LastName :'),
                textEditingController: lastName,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 250,
                child: WidgetButton(
                  label: 'Create New Account',
                  pressFunc: () {
                    if ((phoneNumber.text.isEmpty) ||
                        (idCard.text.isEmpty) ||
                        (email.text.isEmpty) ||
                        (password.text.isEmpty) ||
                        (firsName.text.isEmpty) ||
                        (lastName.text.isEmpty)) {
                      AppSnackBar(
                              title: 'Have Space ?',
                              message: 'Please Fill Everyblank')
                          .errorSnackBar();
                    } else if (phoneNumber.text.length != 10) {
                      AppSnackBar(
                              title: 'Phone Number 10 Digi',
                              message: 'Please Fill Phone Number 10 digi')
                          .errorSnackBar();
                    } else if (idCard.text.length != 13) {
                      AppSnackBar(
                              title: 'Id Card 13 digi',
                              message: 'Please Fill idcard 13 digi')
                          .errorSnackBar();
                    } else if (!(email.text.isEmail)) {
                      AppSnackBar(
                              title: 'Bad Format Email ?',
                              message: 'Please Fill email')
                          .errorSnackBar();
                    } else {
                      CreateNewAccountModel model = CreateNewAccountModel(
                          LoginName: phoneNumber.text,
                          id: idCard.text,
                          email: email.text,
                          password: password.text,
                          Name: firsName.text,
                          Lname: lastName.text);

                      print('model at createNewAccount ---> ${model.toJson()}');

                      AppService().processCreateNewAccount(
                          createNewAccountModel: model);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
