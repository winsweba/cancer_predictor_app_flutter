import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tflite_test/pages/home_page.dart';

class SplashPageHome extends StatefulWidget {
  SplashPageHome({Key? key}) : super(key: key);

  @override
  _SplashPageHomeState createState() => _SplashPageHomeState();
}

class _SplashPageHomeState extends State<SplashPageHome> {
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
      navigator: MyHomePage(),
      durationInSeconds: 5,
    );
  }
}
