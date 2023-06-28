import 'package:get/get.dart';

import '../controllers/admin_status_controller.dart';

class AdminStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminStatusController>(
      () => AdminStatusController(),
    );
  }
}
