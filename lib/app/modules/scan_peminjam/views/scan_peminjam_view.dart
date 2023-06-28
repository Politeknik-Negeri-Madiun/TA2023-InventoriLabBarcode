import 'package:flutter/material.dart';
import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../controllers/scan_peminjam_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Scan_PeminjamView extends GetView<ScanPeminjamController> {
  final scanC = Get.put(ScanPeminjamController(), permanent: true);
  Scan_PeminjamView({Key? key}) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController uidC = TextEditingController();
  final TextEditingController userC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController typC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    uidC.text = auth.currentUser?.uid ?? '';
    userC.text = auth.currentUser?.email ?? '';
    nameC.text = product.name;
    qtyC.text = "${product.qty}";
    typC.text = product.typ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCAN PRODUCT'),
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
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: "product name",
              labelText: "Product Name",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "quantity",
              labelText: "Quantity",
            ),
          ),
          const SizedBox(
            height: 35,
          ),
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
          const SizedBox(
            height: 35,
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (codeC.text.isNotEmpty &&
                    userC.text.isNotEmpty &&
                    uidC.text.isNotEmpty &&
                    nameC.text.isNotEmpty &&
                    qtyC.text.isNotEmpty &&
                    typC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "id": product.productId,
                    "code": codeC.text,
                    "user": userC.text,
                    "uid": uidC.text,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                    "typ": typC.text,
                  });
                  controller.isLoading(false);

                  Get.back();

                  Get.snackbar(
                    hasil["error"] == true ? "Error" : "Success",
                    hasil["message"],
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Semua data wajib diisi.",
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
              () => Text(
                  controller.isLoading.isFalse ? "ADD PRODUCT" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
