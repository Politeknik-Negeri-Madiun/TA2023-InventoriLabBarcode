import 'package:get/get.dart';

import '../controllers/detail_barang_controller.dart';

class DetailBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBarangController>(
      () => DetailBarangController(),
    );
  }
}
