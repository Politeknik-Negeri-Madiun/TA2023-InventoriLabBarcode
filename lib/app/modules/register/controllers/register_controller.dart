import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  RxBool isHidden = true.obs;
  final emailC = TextEditingController();
  final nameC = TextEditingController();
  final nimC = TextEditingController();
  final nohpC = TextEditingController();
  final passC = TextEditingController();
  final roleC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  @override
  void onClose() {
    super.onClose();
  }
}
