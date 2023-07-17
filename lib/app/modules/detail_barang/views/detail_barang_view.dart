import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/detail_barang_controller.dart';

class DetailBarangView extends GetView<DetailBarangController> {
  DetailBarangView({Key? key}) : super(key: key);
  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController userC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController jmlC = TextEditingController();
  final TextEditingController typC = TextEditingController();
  final TextEditingController ketC = TextEditingController();
  final TextEditingController mtkC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    userC.text = product.user;
    nameC.text = product.name;
    qtyC.text = product.qty.toString();
    jmlC.text = product.jml.toString();
    print("QTY: ${qtyC.text}");
    typC.text = product.typ;
    ketC.text = product.ket;
    mtkC.text = product.mtk;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL BARANG'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "product code",
              labelText: "Product Code",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: userC,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "peminjam",
              labelText: "Peminjam",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "product name",
              labelText: "Product Name",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "quantity",
              labelText: "Quantity",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: typC,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "type",
              labelText: "Type",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: mtkC,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "mata kuliah",
              labelText: "Mata Kuliah",
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              String role = snap.data!.data()!["role"];
              if (role == "admin") {
                return TextField(
                  autocorrect: false,
                  controller: ketC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "penerima",
                    labelText: "Penerima",
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          const SizedBox(
            height: 35,
          ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              String role = snap.data!.data()!["role"];
              if (role == "admin") {
                return ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      if (codeC.text.isNotEmpty &&
                          userC.text.isNotEmpty &&
                          nameC.text.isNotEmpty &&
                          qtyC.text.isNotEmpty &&
                          typC.text.isNotEmpty &&
                          mtkC.text.isNotEmpty &&
                          ketC.text.isNotEmpty) {
                        controller.isLoading(true);
                        Map<String, dynamic> hasil =
                            await controller.addProduct({
                          "id": product.productId,
                          "code": codeC.text,
                          "user": userC.text,
                          "name": nameC.text,
                          "qty": int.parse(qtyC.text),
                          "typ": typC.text,
                          "mtk": mtkC.text,
                          "uid": product.uid,
                          "ket": ketC.text,
                        });
                        controller.isLoading(false);

                        Get.back(); // tutup dialog

                        Get.snackbar(
                          hasil["error"] == true ? "Error" : "Berhasil",
                          hasil["message"],
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        Get.snackbar(
                          "Error",
                          "Semua data harus diisi.",
                          duration: const Duration(seconds: 2),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Obx(
                    () => Text(controller.isLoading.isFalse
                        ? "UPDATE PRODUCT"
                        : "LOADING..."),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          StreamBuilder(
            stream: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              String role = snap.data!.data()!["role"];
              if (role == "admin") {
                return TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Product",
                      middleText: "Are you sure to delete this product ?",
                      actions: [
                        OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text("CANCEL"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            controller.isLoadingDelete(true);
                            Map<String, dynamic> hasil = await controller
                                .deleteProduct(product.productId);
                            controller.isLoadingDelete(false);

                            Get.back(); // tutup dialog
                            Get.back(); // balik ke page all products

                            Get.snackbar(
                              hasil["error"] == true ? "Error" : "Berhasil",
                              hasil["message"],
                              duration: const Duration(seconds: 2),
                            );
                          },
                          child: Obx(
                            () => controller.isLoadingDelete.isFalse
                                ? const Text("DELETE")
                                : Container(
                                    padding: const EdgeInsets.all(2),
                                    height: 15,
                                    width: 15,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Text(
                    "Delete product",
                    style: TextStyle(
                      color: Colors.red.shade900,
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
