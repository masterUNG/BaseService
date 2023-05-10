// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/widgets/widget_sticky.dart';
import 'package:baseservice/widgets/widget_transection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:baseservice/models/result_authen_model.dart';
import 'package:baseservice/models/transection_model.dart';
import 'package:baseservice/utility/app_controller.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/utility/app_snackbar.dart';
import 'package:baseservice/widgets/widget_button.dart';
import 'package:baseservice/widgets/widget_icon_button.dart';
import 'package:baseservice/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  const MainHome({
    Key? key,
    required this.resultAuthenModel,
  }) : super(key: key);

  final ResultAuthenModel resultAuthenModel;

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  DateTime dateTime = DateTime.now();

  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    controller.endDateTimes.add(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              'transectionModels ---> ${appController.transectionModels.length}');
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: ListView(
              children: [
                chooseDate(appController, context),
                okButton(appController),
                appController.transectionModels.isEmpty
                    ? const SizedBox()
                    // : Column(
                    //     children: [
                    //       const Divider(color: Colors.grey,),
                    //       header(),
                    //       const Divider(color: Colors.grey,),
                    //       ListView.builder(
                    //         physics: const ScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: appController.transectionModels.length,
                    //         itemBuilder: (context, index) => WidgetTransection(
                    //           transectionModel:
                    //               appController.transectionModels[index],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    : WidgetSticky(),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.arrow_right),
                      ],
                    )
              ],
            ),
          );
        });
  }

  Row header() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: 'วันที่',
                textStyle: AppConstant().h3Style(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: 'กองทุน',
                textStyle: AppConstant().h3Style(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: 'บริษัทจัดการ',
                textStyle: AppConstant().h3Style(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: 'รายการ',
                textStyle: AppConstant().h3Style(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row okButton(AppController appController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WidgetButton(
          label: 'OK',
          pressFunc: () {
            if (appController.startDateTimes.isEmpty) {
              AppSnackBar(
                      title: 'Start Date ?',
                      message: 'Please Choose Start Date')
                  .errorSnackBar();
            } else {
              AppService()
                  .readTransection(resultAuthenModel: widget.resultAuthenModel);
            }
          },
        ),
        const SizedBox(
          width: 35,
        ),
      ],
    );
  }

  Padding chooseDate(AppController appController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appController.startDateTimes.isEmpty
                  ? const WidgetText(data: 'dd-MM-yyyy')
                  : WidgetText(
                      data: AppService().changeTimeToString(
                          dateTime: appController.startDateTimes.last)),
              WidgetIconButton(
                iconData: Icons.calendar_month,
                pressFunc: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime(dateTime.year - 4),
                          lastDate: dateTime)
                      .then((value) {
                    if (value != null) {
                      appController.startDateTimes.add(value);
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appController.endDateTimes.isEmpty
                  ? const WidgetText(data: 'dd-MM-yyyy')
                  : WidgetText(
                      data: AppService().changeTimeToString(
                          dateTime: appController.endDateTimes.last)),
              WidgetIconButton(
                iconData: Icons.calendar_month,
                pressFunc: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime(dateTime.year - 4),
                          lastDate: dateTime)
                      .then((value) {
                    if (value != null) {
                      appController.endDateTimes.add(value);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
