import 'package:get/get.dart';

import '../controllers/peminjaman_barang_controller.dart';

class PeminjamanBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeminjamanBarangController>(
      () => PeminjamanBarangController(),
    );
  }
}
