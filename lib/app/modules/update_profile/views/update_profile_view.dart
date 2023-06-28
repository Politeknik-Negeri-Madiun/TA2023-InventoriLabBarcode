import 'dart:io';
import 'package:barcode_ta/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = user["email"];
    controller.nameC.text = user["name"];
    controller.nohpC.text = user["nohp"];
    controller.nimC.text = user["nim"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextField(
            readOnly: true,
            controller: controller.emailC,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "masukkan email",
              labelText: "Masukkan Email",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "masukkan nama lengkap",
              labelText: "Masukkan Nama Lengkap",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nohpC,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "masukkan no hp",
              labelText: "Masukkan No Hp",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nimC,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "masukkan nim",
              labelText: "Masukkan NIM",
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Photo Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user["profile"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteProfile(user["uid"]);
                            },
                            child: Text(
                              "DELETE",
                              style: whiteTextStyle.copyWith(
                                  color: dangerColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text("no image");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Choosen"),
              ),
            ],
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "UPDATE PROFILE"
                  : "BERHASIL..."),
            ),
          ),
        ],
      ),
    );
  }
}
