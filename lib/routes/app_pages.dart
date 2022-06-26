import 'package:get/get.dart';
import 'package:getx_getconnect_learn/pages/add_page.dart';
import 'package:getx_getconnect_learn/pages/profile_pages.dart';
import 'package:getx_getconnect_learn/routes/route_name.dart';

import '../bindings/addB.dart';
import '../bindings/profileB.dart';
import '../pages/home_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteName.profile,
      page: () => ProfilePage(),
      binding: ProfileB(),
    ),
    GetPage(
      name: RouteName.add,
      page: () => AddPage(),
      binding: AddUserB(),
    ),
  ];
}
