import 'package:barcode_ta/app/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;
  RxList<ProductModel> filteredProducts = List<ProductModel>.empty().obs;
  RxList<ProductModel> allProductsMain = RxList<ProductModel>();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("Users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamStatusBarang() {
    String uid = auth.currentUser!.uid;
    return firestore
        .collection("history")
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
