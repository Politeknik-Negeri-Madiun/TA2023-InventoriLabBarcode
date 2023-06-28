import 'package:barcode_ta/app/controllers/auth_controller.dart';
import 'package:barcode_ta/app/controllers/permission_controller.dart';
import 'package:barcode_ta/app/modules/add_product/controllers/add_product_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/splash.dart';
import 'firebase_options.dart';

final permissionC = Get.put(PermissionController(), permanent: true);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  final addC = Get.put(AddProductController(), permanent: true);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      // future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapAuth) {
        if (snapAuth.connectionState == ConnectionState.waiting) {
          print(snapAuth.hasData);
          return SplashScreen();
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapAuth.hasData ? Routes.PEMINJAMAN_BARANG : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
