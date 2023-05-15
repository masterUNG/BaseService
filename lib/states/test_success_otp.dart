import 'package:baseservice/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class TestSuccessOtp extends StatelessWidget {
  const TestSuccessOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(data: 'Success Otp'),),);
  }
}