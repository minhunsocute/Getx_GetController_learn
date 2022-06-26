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
          UserProvides().postUser(name, email, phone).then((value) {
            print(value.body);
            users.add(User(
              id: value.body["name"].toString(),
              name: name,
              email: email,
              phone: phone,
            ));
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
        UserProvides().editData(id, newName, newEmail, newPhone).then((_) {
          print(_.body);
          users[users.indexWhere((element) => element.id == id)].name = newName;
          users[users.indexWhere((element) => element.id == id)].email =
              newEmail;
          users[users.indexWhere((element) => element.id == id)].phone =
              newPhone;
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
}
