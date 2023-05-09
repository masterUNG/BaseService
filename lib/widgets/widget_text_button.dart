// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baseservice/utility/app_constant.dart';
import 'package:flutter/material.dart';

import 'package:baseservice/widgets/widget_text.dart';

class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.color,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressFunc,
        child: WidgetText(
          data: label,
          textStyle: AppConstant().h3Style(color: color),
        ));
  }
}
