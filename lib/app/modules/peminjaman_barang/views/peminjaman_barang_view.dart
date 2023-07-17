import 'package:barcode_ta/app/controllers/auth_controller.dart';
import 'package:barcode_ta/app/modules/admin_pengembalian/views/admin_pengembalian_view.dart';
import 'package:barcode_ta/app/modules/admin_status/views/admin_status_view.dart';
import 'package:barcode_ta/app/modules/pengembalian/views/pengembalian_view.dart';
import 'package:barcode_ta/app/modules/profile/views/profile_view.dart';
import 'package:barcode_ta/app/modules/status/views/status_view.dart';
import 'package:barcode_ta/app/modules/stok_barang/views/stok_barang_view.dart';
import 'package:barcode_ta/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../controllers/peminjaman_barang_controller.dart';
import 'package:barcode_ta/shared/shared.dart';

class Peminjaman_BarangView extends GetView<PeminjamanBarangController> {
  final AuthController authC = Get.find<AuthController>();
  Peminjaman_BarangView({Key? key}) : super(key: key);
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
              right: 0,
              child: Image.asset(
                "assets/logo/ellipse4.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/logo/ellipse3.png",
                width: size.width * 0.3,
              ),
            ),
            ListView(
              padding: EdgeInsets.all(20),
              children: [
                Image.asset(
                  "assets/logo/logo2.png",
                  height: 110,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Workshop Kerja Bangku & Pengelasan",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                  width: 150.0,
                  child: Divider(
                    color: Color.fromARGB(255, 6, 28, 26),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: GestureDetector(
                      onTap: () => Get.to(
                        Stok_BarangView(),
                      ),
                      child: Text(
                        'List Ketersediaan Barang',
                        style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: greyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.streamRole(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    String role = snap.data!.data()!["role"];
                    if (role == "admin") {
                      return SizedBox();
                    } else {
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () async {
                              String barcode =
                                  await FlutterBarcodeScanner.scanBarcode(
                                "#000000",
                                "CANCEL",
                                true,
                                ScanMode.QR,
                              );

                              // Get data dari firebase search by product id
                              Map<String, dynamic> hasil =
                                  await controller.getProductById(barcode);
                              if (hasil["error"] == false) {
                                Get.toNamed(Routes.SCAN_PEMINJAM,
                                    arguments: hasil["data"]);
                              } else {
                                Get.snackbar(
                                  "error",
                                  hasil["message"],
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                            child: Text(
                              'Scan Barang',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.streamRole(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    String role = snap.data!.data()!["role"];
                    if (role == "admin") {
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () => Get.to(
                              AdminStatusView(),
                            ),
                            child: Text(
                              'Peminjaman Barang',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () => Get.to(
                              StatusView(),
                            ),
                            child: Text(
                              'Peminjaman Barang',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.streamRole(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    String role = snap.data!.data()!["role"];
                    if (role == "admin") {
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () => Get.to(
                              AdminPengembalianView(),
                            ),
                            child: Text(
                              'Pengembalian Barang',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () => Get.to(
                              PengembalianView(),
                            ),
                            child: Text(
                              'Pengembalian Barang',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () => Get.to(
                  ProfileView(),
                ),
                child: Image.asset(
                  "assets/icons/image3.png",
                  width: size.width * 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          authC.logout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
