import 'package:flutter/material.dart';
import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../controllers/scan_peminjam_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

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
  final TextEditingController jmlC = TextEditingController();
  final TextEditingController typC = TextEditingController();
  final TextEditingController mtkC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    uidC.text = auth.currentUser?.uid ?? '';
    userC.text = auth.currentUser?.displayName ?? '';
    nameC.text = product.name;
    qtyC.text = "${product.qty}";
    jmlC.text = "${product.jml}";
    typC.text = product.typ;
    mtkC.text = product.mtk;
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
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "stock quantity",
              labelText: "Stock Quantity",
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "Out Quantity",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.decreaseQuantity();
                  jmlC.text = controller.jmlC.value.toString();
                },
                icon: Icon(Icons.remove),
              ),
              Obx(() => Text(
                    controller.jmlC.value.toString(),
                    style: TextStyle(fontSize: 18),
                  )),
              IconButton(
                onPressed: () {
                  controller.increaseQuantity();
                  jmlC.text = controller.jmlC.value.toString();
                },
                icon: Icon(Icons.add),
              ),
            ],
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
          const SizedBox(
            height: 35,
          ),
          DropdownButtonFormField(
            value: mtkC.text.isEmpty ? null : mtkC.text,
            onChanged: (newValue) {
              // Tambahkan kode untuk mengubah nilai pada controller hanya ketika ada item yang dipilih
              if (newValue != null) {
                mtkC.text = newValue.toString();
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Pilih Mata Kuliah",
              labelText: "Mata Kuliah",
            ),
            items: [
              DropdownMenuItem(
                value: "Proses Manufactur",
                child: Text("Proses Manufactur"),
              ),
              DropdownMenuItem(
                value: "Teknologi Pengelasan",
                child: Text("Teknologi Pengelasan"),
              ),
              DropdownMenuItem(
                value: "Ilmu Bahan",
                child: Text("Ilmu Bahan"),
              ),
              DropdownMenuItem(
                value: "Gambar Teknik",
                child: Text("Gambar Teknik"),
              ),
              DropdownMenuItem(
                value: "Lain - Lain",
                child: Text("Lain - Lain"),
              ),
            ],
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
                    typC.text.isNotEmpty &&
                    mtkC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "id": product.productId,
                    "code": codeC.text,
                    "user": userC.text,
                    "uid": uidC.text,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                    "typ": typC.text,
                    "mtk": mtkC.text,
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
