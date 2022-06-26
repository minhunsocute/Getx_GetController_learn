import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx_getconnect_learn/providers/userProviders.dart';
import 'package:getx_getconnect_learn/routes/route_name.dart';

import '../Controllers/userController.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usersC = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Users',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.add);
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // setState(() {
              usersC.getAllData();
              // });
            },
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: usersC.users.isEmpty
                ? Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  )
                : ListView.builder(
                    itemCount: usersC.users.length,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(),
                      title: Text("${usersC.users[i].name}"),
                      subtitle: Text("${usersC.users[i].email}"),
                      trailing: IconButton(
                        onPressed: () => usersC.deleteUser(usersC.users[i].id),
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red[900],
                        ),
                      ),
                      onTap: () => Get.toNamed(
                        RouteName.profile,
                        arguments: usersC.users[i].id,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
