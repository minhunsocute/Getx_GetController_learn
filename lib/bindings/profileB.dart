import 'package:get/get.dart';

import '../Controllers/profileController.dart';

class ProfileB implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileC());
  }
}
