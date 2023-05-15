import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/widgets/widget_button.dart';
import 'package:baseservice/widgets/widget_form.dart';
import 'package:baseservice/widgets/widget_text.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: WidgetText(
          data: 'Chat',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('chatModels ---> ${appController.chatModels.length}');
              return SizedBox(
                width: boxConstraints.maxWidth,
                height: boxConstraints.maxHeight,
                child: Stack(
                  children: [
                    appController.chatModels.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: appController.chatModels.length,
                            itemBuilder: (context, index) => BubbleSpecialThree(
                              text: appController.chatModels[index].message,
                              color: Theme.of(context).primaryColor,textStyle: AppConstant().h3Style(color: Colors.white),
                            ),
                          ),
                    Positioned(
                      bottom: 16,
                      child: SizedBox(
                        width: boxConstraints.maxWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            WidgetForm(
                              textEditingController: textEditingController,
                              margin: 0,
                            ),
                            WidgetButton(
                              label: 'Send',
                              pressFunc: () {
                                if (textEditingController.text.isNotEmpty) {
                                  AppService().insertDataToFirebase(
                                      message: textEditingController.text);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
