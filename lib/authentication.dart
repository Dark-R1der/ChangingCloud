import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/global_controller.dart';
import 'package:newiet/views/ui/pages/home.dart';
import 'package:newiet/views/ui/pages/sign_up.dart';

class Authentication extends StatelessWidget {
  Authentication({
    super.key,
  });

  final GlobalController globalController = Get.find<GlobalController>();

  Future<String> getRole() async {
    await globalController.loadRoleFromSharedPreferences();

    if (FirebaseAuth.instance.currentUser == null) {
      return "Nope";
    } else {
      return globalController.role.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (globalController.role.value == "Node") {
              return HomePage();
            } else if (globalController.role.value == "Organization") {
              return HomePage();
            } else {
              return SignUpPage();
            }
          } else {
            return SignUpPage();
          }
        }
        return SignUpPage();
      },
    );
  }
}
