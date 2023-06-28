import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PeminjamanBarangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("Users").doc(uid).snapshots();
  }

  Future<Map<String, dynamic>> getProductById(String codeBarang) async {
    try {
      var hasil = await firestore
          .collection("products")
          .where("code", isEqualTo: codeBarang)
          .get();

      if (hasil.docs.isEmpty) {
        return {
          "error": true,
          "message": "Tidak mendapatkan detail product dari product code ini.",
        };
      }

      Map<String, dynamic> data = hasil.docs.first.data();

      return {
        "error": false,
        "message": "Berhasil mendapatkan detail product dari product code ini.",
        "data": ProductModel.fromJson(data),
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak mendapatkan detail product dari product code ini.",
      };
    }
  }
}
