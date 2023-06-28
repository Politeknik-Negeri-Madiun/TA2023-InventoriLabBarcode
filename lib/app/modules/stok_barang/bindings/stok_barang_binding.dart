import 'package:get/get.dart';

import '../controllers/stok_barang_controller.dart';

class StokBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StokBarangController>(
      () => StokBarangController(),
    );
  }
}
