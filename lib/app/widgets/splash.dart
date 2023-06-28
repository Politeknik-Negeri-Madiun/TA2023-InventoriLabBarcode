import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: Get.width * 2,
            height: Get.width * 2,
            child: Image.asset("assets/logo/splash3.png"),
          ),
        ),
      ),
    );
  }
}
