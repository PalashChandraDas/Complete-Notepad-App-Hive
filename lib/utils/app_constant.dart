import 'package:flutter/material.dart';

class AppConstant {

  static SizedBox kDefaultGap = const SizedBox(height: 10,);

  static kWidth({required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  static kHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  static customToast({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
