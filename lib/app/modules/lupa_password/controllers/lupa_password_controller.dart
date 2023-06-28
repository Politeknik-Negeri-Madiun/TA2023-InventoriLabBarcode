import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.snackbar("Berhasil",
            "Kami telah mengirimkan email reset password. Mohon periksa email!");
        Get.back();
      } catch (e) {
        Get.snackbar(
            "Terjadi kesalahan", "Tidak dapat mengirim email reset password.");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
