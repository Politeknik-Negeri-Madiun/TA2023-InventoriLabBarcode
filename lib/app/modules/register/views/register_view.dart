// import 'package:barcode_ta/app/modules/login/views/login_view.dart';
// import 'package:barcode_ta/app/modules/peminjaman_barang/views/peminjaman_barang_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/register_controller.dart';
import 'package:barcode_ta/shared/shared.dart';

class RegisterView extends GetView<RegisterController> {
  final authC = Get.find<AuthController>();
  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/logo/ellipse1.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/logo/ellipse2.png",
                width: size.width * 0.3,
              ),
            ),
            ListView(
              padding: EdgeInsets.all(15),
              children: [
                Image.asset(
                  "assets/logo/logo2.png",
                  height: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Silahkan Daftar!",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
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
                  controller: controller.nimC,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "masukkan nim",
                    labelText: "Masukkan NIM",
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
                Obx(
                  () => TextField(
                    autocorrect: false,
                    controller: controller.passC,
                    keyboardType: TextInputType.text,
                    obscureText: controller.isHidden.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "masukkan password",
                      labelText: "Masukkan Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHidden.toggle();
                        },
                        icon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: GestureDetector(
                      onTap: () => authC.register(
                          controller.emailC.text,
                          controller.nameC.text,
                          controller.nimC.text,
                          controller.nohpC.text,
                          controller.passC.text),
                      child: Text(
                        'DAFTAR',
                        style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: whiteColor),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: whiteTextStyle.copyWith(
                          color: primaryColor, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        "Masuk",
                        style: whiteTextStyle.copyWith(
                            color: dangerColor, fontSize: 18),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
