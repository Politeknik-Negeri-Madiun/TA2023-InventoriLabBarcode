import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class StokBarangController extends GetxController {
  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;
  RxList<ProductModel> filteredProducts = List<ProductModel>.empty().obs;
  RxList<ProductModel> allProductsMain = RxList<ProductModel>();

  RxBool isSearching = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("Users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamStokBarang() async* {
    yield* firestore.collection("products").snapshots();
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      // Jika kata kunci pencarian kosong, tidak ada pencarian yang dilakukan
      isSearching.value = false;
      filteredProducts.clear();
    } else {
      // Jika kata kunci pencarian tidak kosong, lakukan pencarian
      isSearching.value = true;

      String lowercaseKeyword = keyword.toLowerCase();

      Stream<List<ProductModel>> filteredStream = firestore
          .collection("products")
          .where("name", isGreaterThanOrEqualTo: lowercaseKeyword)
          .where("name", isLessThan: lowercaseKeyword + 'z')
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList();
      });

      filteredProducts.bindStream(filteredStream);
    }
  }

  void downloadCatalog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("products").get();

    // reset all products -> untuk mengatasi duplikat
    allProducts([]);

    // isi data allProducts dari database
    for (var element in getData.docs) {
      allProducts.add(
        ProductModel.fromJson(
          element.data(),
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allProducts.length,
            (index) {
              ProductModel product = allProducts[index];
              return pw.TableRow(
                children: [
                  // NO
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      "${index + 1}",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 7,
                      ),
                    ),
                  ),
                  // Kode Barang
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      product.code,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 7,
                      ),
                    ),
                  ),
                  // Nama Barang
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      product.name,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 7,
                      ),
                    ),
                  ),
                  // Qty
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      "${product.qty}",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 7,
                      ),
                    ),
                  ),
                  // Typ
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      product.typ,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 7,
                      ),
                    ),
                  ),
                  // QR Code
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: pw.Barcode.qrCode(),
                      data: product.code,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              );
            },
          );

          return [
            pw.Center(
              child: pw.Text(
                "CATALOG PRODUCTS",
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex("#000000"),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    // NO
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                        "NO",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // Kode Barang
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                        "Product Code",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 7,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // Nama Barang
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        "Product Name",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 7,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // Qty
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                        "Quantity",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // Typ
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                        "Type",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // QR Code
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                        "QR Code",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 7,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...allData,
              ],
            ),
          ];
        },
      ),
    );

    // simpan
    // Uint8List bytes = await pdf.save();

    // buat file kosong  di direktori
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/mydocument.pdf';
    final file = File(filePath);

    // memasukkan data bytes -> file kosong
    await file.writeAsBytes(await pdf.save());

    var status = await Permission.manageExternalStorage.request();

    // open file
    if (status.isGranted) {
      // Izin diberikan, lakukan tindakan yang diinginkan
      // Contoh: Generate dan buka file PDF
      if (await file.exists()) {
        final fileDir = file.path;
        final result = await OpenFile.open(filePath);

        if (result.type != ResultType.done) {
          throw 'Tidak dapat membuka file PDF';
        }
      } else {
        throw 'File PDF tidak ditemukan';
      }
    } else if (status.isDenied) {
      // Izin ditolak, tampilkan pesan atau lakukan tindakan lain
      Get.snackbar(
        'Izin Ditolak',
        'Anda telah menolak izin akses penyimpanan.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (status.isPermanentlyDenied) {
      // Izin ditolak secara permanen, tampilkan pesan atau lakukan tindakan lain
      Get.dialog(
        AlertDialog(
          title: Text('Izin Ditolak Secara Permanen'),
          content: Text(
            'Anda telah menolak izin akses penyimpanan secara permanen. '
            'Mohon izinkan akses melalui Pengaturan Aplikasi.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Get.back();
              },
              child: Text('Pengaturan Aplikasi'),
            ),
          ],
        ),
      );
    }
  }
}
