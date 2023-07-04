import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tflite_test/pages/login.dart';

class SplashPageLogin extends StatefulWidget {
  SplashPageLogin({Key? key}) : super(key: key);

  @override
  _SplashPageLoginState createState() => _SplashPageLoginState();
}

class _SplashPageLoginState extends State<SplashPageLogin> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/logo.jpg'),
      title: Text(
        "Skin Cancer Detection",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: LoginPage(),
      durationInSeconds: 5,
    );
  }
}
