import 'package:barcode_ta/app/routes/app_pages.dart';
import 'package:barcode_ta/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  LoginView({Key? key}) : super(key: key);
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
                  height: 110,
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/logo/login.png",
                  height: 75,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "masukkan email",
                    labelText: "Masukkan Email",
                  ),
                ),
                SizedBox(
                  height: 25,
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
                  height: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.LUPA_PASSWORD),
                      child: Text(
                        "Lupa Password ?",
                        style: whiteTextStyle.copyWith(
                            color: dangerColor, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 43,
                    ),
                    Container(
                      height: 60,
                      width:
                          MediaQuery.of(context).size.width - 2 * defaultMargin,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () => authC.login(
                              controller.emailC.text, controller.passC.text),
                          child: Text(
                            'MASUK',
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
                          "Belum punya akun?",
                          style: whiteTextStyle.copyWith(
                              color: primaryColor, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.REGISTER),
                          child: Text(
                            "Daftar",
                            style: whiteTextStyle.copyWith(
                                color: dangerColor, fontSize: 18),
                          ),
                        )
                      ],
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
