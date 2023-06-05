import 'package:flutter/material.dart';
import 'package:task01/Services/AuthenticationServices.dart';
import 'package:task01/Services/comom_keys.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Ui_Pages/HomePage.dart';
import 'package:task01/Ui_Pages/Login_Screen.dart';

import '../Services/dimesion.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String? sval;
    storage.read(key: session_userid).then((uvalue) => userid = uvalue);
    storage.read(key: session_key).then(
          (value) => sval = value,
        );
    Future.delayed(Duration(seconds: splash_duration), () {
      if (sval == string_true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
      splash_image,
      height: DimenResource.D_100,
      width: DimenResource.D_100,
    )));
  }
}
