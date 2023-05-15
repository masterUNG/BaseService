// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:baseservice/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.obsecu,
    this.textEditingController,
    this.suffixWidget,
    this.margin,
    this.labelWidget,
    this.textInputType,
    this.maxlength,
  }) : super(key: key);

  final String? hint;
  final bool? obsecu;
  final TextEditingController? textEditingController;
  final Widget? suffixWidget;
  final double? margin;
  final Widget? labelWidget;
  final TextInputType? textInputType;
  final int? maxlength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin ?? 16),
      width: 250,
      height: maxlength == null ? 40 : 60,
      child: TextFormField(
        maxLength: maxlength,
        keyboardType: textInputType,
        controller: textEditingController,
        obscureText: obsecu ?? false,
        style: AppConstant().h3Style(),
        decoration: InputDecoration(
          label: labelWidget,
          suffixIcon: suffixWidget,
          hintStyle: AppConstant().h3Style(),
          hintText: hint,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
