import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  RxBool isHidden = true.obs;
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
