import 'package:baseservice/models/transection_model.dart';
import 'package:baseservice/utility/app_constant.dart';
import 'package:baseservice/utility/app_service.dart';
import 'package:baseservice/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetTransection extends StatelessWidget {
  const WidgetTransection({
    Key? key,
    required this.transectionModel,
  }) : super(key: key);

  final TransectionModel transectionModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: AppService()
                    .cutWord(string: transectionModel.TranDate, start: 0, end: 10),
                textStyle: AppConstant().h3Style(size: 10),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: WidgetText(
            data: transectionModel.Fund_Code,
            textStyle: AppConstant().h3Style(size: 10),
          ),
        ),
        Expanded(
          flex: 1,
          child: WidgetText(
            data: transectionModel.Amc_Name,
            textStyle: AppConstant().h3Style(size: 10),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                data: AppService().findTranTypeCode(
                    tranTypecodex: transectionModel.TranType_Code),
                textStyle: AppConstant().h3Style(size: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
