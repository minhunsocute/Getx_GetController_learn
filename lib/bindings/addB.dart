import 'package:get/get.dart';

import '../Controllers/addController.dart';

class AddUserB implements Bindings {
  @override
  void dependencies() {
    Get.put(AddC());
  }
}
