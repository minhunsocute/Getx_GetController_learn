import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserProvides extends GetConnect {
  final url =
      "https://tiktik-tute-default-rtdb.asia-southeast1.firebasedatabase.app/";
  final linkApiGetAll = "http://localhost:2011/user/getAll";
  final linkApiDeleteUser = "http://localhost:2011/user/deleteUser/";
  final linkApiPostUser = "http://localhost:2011/user/signUp/";
  // get request
  Future<Response> getUser(int id) => get('http://youapi/users/$id');
  // post data

  Future<Response> postUser(String name, String email, String phone) async {
    final body = json.encode({
      "name": name,
      "email": email,
      "phone": phone,
    });
    print(body.toString());
    return post(url + "users.json", body);
  }

  Future<Response> deleteData(String id) {
    return delete(url + "users/$id.json");
  }

  Future<Response> editData(
      String id, String newName, String newEmail, String newPhone) {
    final body = json.encode({
      "name": newName,
      "email": newEmail,
      "phone": newPhone,
    });

    return patch(url + "users/$id.json", body);
  }

  Future<List<User>> getAllUser() async {
    print('Call this function');
    var client = http.Client();
    var uri = Uri.parse(linkApiGetAll);
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var jsonString = response.body;
//      print(jsonString);
        List<User> result = [];
        if (jsonString != "") {
          var temp = json.decode(jsonString);
          for (var item in temp) {
            result.add(
              User(
                  id: item["id"],
                  name: item["name"],
                  email: item["email"],
                  phone: "0935703991"),
            );
          }
        }
        return result;
      }
    } catch (err) {
      print(err.toString());
    }
    return [];
  }

  Future<List<User>> deleteUser(String email) async {
    print('Call delete function');
    var client = http.Client();
    var uri = Uri.parse(linkApiDeleteUser + email);
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
//      print(jsonString);
      List<User> result = [];
      var temp = json.decode(jsonString);
      for (var item in temp) {
        result.add(
          User(
              id: "",
              name: item["name"],
              email: item["email"],
              phone: "0935703991"),
        );
      }
      return result;
    }
    return [];
  }

  Future<String> postUserApi(String email, String name, String phone) async {
    print("call post function");
    var client = http.Client();
    var uri = Uri.parse(linkApiPostUser + email + "/dsds01111/" + name + "/20");
    var response = await client.post(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonString;
    }
    return "";
  }
}

//db.user.find().pretty()
