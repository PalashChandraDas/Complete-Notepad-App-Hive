import 'package:flutter/material.dart';

class CustomRouter{

  static push({required BuildContext context, required Widget page}){
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
  }

  static pushNamed({required BuildContext context, required String page, Map<String, dynamic>? arguments}){
    return Navigator.pushNamed(context, page, arguments: arguments,);
  }
  static pushReplacement({required BuildContext context, required Widget page}){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page,));
  }

  static pushReplacementNamed({required BuildContext context, required String page, Map<String, String>? arguments}){
    return Navigator.pushReplacementNamed(context, page, arguments: arguments,);
  }

  static pop({required BuildContext context}) {
    return Navigator.of(context).pop();
  }
}