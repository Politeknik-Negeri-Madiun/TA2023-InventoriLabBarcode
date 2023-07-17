import 'package:get/get.dart';

import '../controllers/admin_pengembalian_controller.dart';

class AdminPengembalianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPengembalianController>(
      () => AdminPengembalianController(),
    );
  }
}
