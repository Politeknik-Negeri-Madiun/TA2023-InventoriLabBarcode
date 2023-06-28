import 'package:get/get.dart';

import '../controllers/scan_peminjam_controller.dart';

class ScanPeminjamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanPeminjamController>(
      () => ScanPeminjamController(),
    );
  }
}
