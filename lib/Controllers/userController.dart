import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_getconnect_learn/providers/userProviders.dart';
import 'package:video_player/video_player.dart';

import '../models/user.dart';

class UserController extends GetxController {
  var users = List<User>.empty().obs;

  void SnackBarError(String msg) {
    Get.snackbar("Error", msg, duration: Duration(seconds: 2));
  }

  getAllData() async {
    List<User> temp = await UserProvides().getAllUser();
    for (var item in temp) {
      users.add(item);
    }
  }

  void add(String name, String email, String phone) {
    if (name != "" && email != "" && phone != "") {
      if (email.contains('@')) {
        String date = DateTime.now().toString();
        try {
          UserProvides().postUserApi(email, name, "0935703991").then((value) {
            users.add(User(id: '20', email: email, name: name, phone: phone));
            Get.snackbar("Post User", value.toString());
          });
        } catch (err) {
          SnackBarError(err.toString());
        }
        Get.back();
      } else {
        SnackBarError("Email is not format");
      }
    } else {
      SnackBarError("Data is error");
    }
  }

  User userbyId(String id) {
    return users.firstWhere((element) => element.id == id);
  }

  void edit(String id, String newName, String newEmail, String newPhone) {
    if (newName != '' && newEmail != '' && newPhone != '') {
      if (newEmail.contains('@')) {
        UserProvides()
            .editDataWithApi(newEmail, newName, "22222222", "40", id)
            .then((_) {
          users[users.indexWhere((element) => element.email == newEmail)].name =
              newName;
          users[users.indexWhere((element) => element.email == newEmail)]
              .email = newEmail;
          users[users.indexWhere((element) => element.email == newEmail)]
              .phone = newPhone;
        });
        Get.back();
      } else {
        SnackBarError('Email is not format');
      }
    } else {
      SnackBarError("Data is error");
    }
  }

  Future<bool> deleteUser(String id) async {
    bool _deleted = false;
    await Get.defaultDialog(
        title: "DELETE",
        middleText: "Do you want delete this user",
        textConfirm: "Yes",
        textCancel: "No",
        confirmTextColor: Colors.white,
        onConfirm: () {
          UserProvides().deleteData(id).then((_) {
            print(_.body);
            users.removeWhere((element) => element.id == id);
            _deleted = true;
          });
          Get.back();
        });
    return _deleted;
  }

  Future<bool> deleteUserApi(String email) async {
    bool _deleted = false;
    await Get.defaultDialog(
        title: "DELETE",
        middleText: "Do you want delete this user",
        textConfirm: "YES",
        textCancel: "NO",
        confirmTextColor: Colors.white,
        onConfirm: () {
          UserProvides().deleteUser(email).then((_) {
            users.removeWhere((element) => element.email == email);
            _deleted = true;
          });
          Get.back();
        });
    return _deleted;
  }
}
