import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxInt qtyC = RxInt(0);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("Users").doc(uid).snapshots();
  }

  void increaseQuantity() {
    qtyC.value++;
  }

  void decreaseQuantity() {
    qtyC.value--;
  }

  // void decreaseQuantity() {
  //   if (qtyC.value > 0) {
  //     qtyC.value--;
  //   }
  // }

  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection("products").doc(data["id"]).update({
        "name": data["name"],
        "qty": data["qty"],
        "typ": data["typ"],
      });

      return {
        "error": false,
        "message": "Berhasil update product.",
      };
    } catch (e) {
      return {
        "error": true,
        "message ": "Tidak dapat menambah product.",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await firestore.collection("products").doc(id).delete();
      return {
        "error": false,
        "message": "Berhasil delete product.",
      };
    } catch (e) {
      return {
        "error": true,
        "message ": "Tidak dapat delete product.",
      };
    }
  }
}
