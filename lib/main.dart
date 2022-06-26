import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_getconnect_learn/Controllers/userController.dart';
import 'package:getx_getconnect_learn/pages/home_page.dart';
import 'package:getx_getconnect_learn/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final userC = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      getPages: AppPages.pages,
    );
  }
}
