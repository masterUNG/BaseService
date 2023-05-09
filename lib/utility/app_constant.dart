import 'package:flutter/material.dart';

class AppConstant {
  static String urlApiAuthen = 'http://115.31.144.227:3009/api/user/signin';
  static String urlApiCreateNewAccount =
      'http://115.31.144.227:3009/api/user/signup';

  static String appName = 'Best Service';

  BoxDecoration basicBox({required BuildContext context}) {
    return BoxDecoration(color: Theme.of(context).primaryColorLight);
  }

  BoxDecoration linearBox({required BuildContext context}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, Theme.of(context).primaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration radienBox({required BuildContext context}) {
    return BoxDecoration(
      gradient: RadialGradient(
          colors: <Color>[Colors.white, Theme.of(context).primaryColor],
          radius: 1,
          center: const Alignment(-0.35, -0.6)),
    );
  }

  BoxDecoration imageBox() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/bg.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  TextStyle h1Style({double? size, Color? color}) {
    return TextStyle(
        fontSize: size ?? 36, fontWeight: FontWeight.bold, color: color);
  }

  TextStyle h2Style({double? size, Color? color}) {
    return TextStyle(
        fontSize: size ?? 20, fontWeight: FontWeight.w700, color: color);
  }

  TextStyle h3Style({double? size, Color? color}) {
    return TextStyle(
        fontSize: size ?? 14, fontWeight: FontWeight.normal, color: color);
  }
}
