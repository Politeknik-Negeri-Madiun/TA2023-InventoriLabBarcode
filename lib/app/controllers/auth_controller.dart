import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.userChanges();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamDataUsers() {
    CollectionReference users = firestore.collection("Users");
    return users.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUserDoc() async {
    String uid = auth.currentUser!.uid;
    DocumentReference user = firestore.collection("Users").doc(uid);
    return user.get();
  }

  void syncUsers(String email, String name, String nohp, String nim,
      String password) async {
    String uid = auth.currentUser!.uid.toString();

    CollectionReference users = firestore.collection('Users');
    try {
      users.doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'nohp': nohp,
        'nim': nim,
        'password': password,
        'role': 'pengguna',
      });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak Berhasil Memasukkan Data",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> role() async {
    String uid = auth.currentUser!.uid;
    DocumentReference users = firestore.collection('Users').doc(uid);
    return users.get();
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAllNamed(Routes.PEMINJAMAN_BARANG);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email tidak ditemukan.',
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Password salah.',
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Tidak dapat masuk.',
      );
    }
  }

  void register(String email, String name, String nohp, String nim,
      String password) async {
    try {
      UserCredential myUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await myUser.user?.updateDisplayName(name);
      syncUsers(email, name, nohp, nim, password);
      Get.offAllNamed(Routes.PEMINJAMAN_BARANG);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('the account already exists for that email.');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email sudah dipakai pada akun tersebut.',
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Tidak dapat mendaftarkan akun ini',
      );
    }
  }

  void signup(String Email, String Password) async {}
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
