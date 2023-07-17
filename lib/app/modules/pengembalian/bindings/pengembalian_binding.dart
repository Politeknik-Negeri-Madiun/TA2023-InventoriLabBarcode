import 'package:get/get.dart';

import '../controllers/pengembalian_controller.dart';

class PengembalianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengembalianController>(
      () => PengembalianController(),
    );
  }
}
