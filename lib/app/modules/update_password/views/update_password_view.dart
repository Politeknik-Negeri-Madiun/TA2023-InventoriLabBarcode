import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  final profileC = Get.put(UpdatePasswordController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          TextField(
            controller: controller.currC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Current Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 25),
          TextField(
            controller: controller.newC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 25),
          TextField(
            controller: controller.confirmC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.updatePass();
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "CHANGE PASSWORD"
                  : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
