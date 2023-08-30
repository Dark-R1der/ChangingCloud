import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/views/ui/animations/sign_up_bar_animation.dart';
import 'package:newiet/views/ui/controller/sign_up_controller.dart';
import 'package:newiet/views/widgetsd/login_widget.dart';
import 'package:newiet/views/widgetsd/sign_widget.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController signUpController =
      Get.put(SignUpController()); // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    TextEditingController textEditingController = TextEditingController();

    // var space = Obx(() {
    //   return
    // });

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF5Ebd8),
        body: Stack(
          children: [
            Obx(() {
              print("${signUpController.selectedIndex.value} ===========");
              return AnimatedAppBar(
                selected1:
                    signUpController.selectedIndex.value == 0 ? false : true,
                selected2:
                    signUpController.selectedIndex.value == 1 ? false : true,
                selected3:
                    signUpController.selectedIndex.value == 2 ? false : true,
              );
            }),
            Obx(() {
              return AnimatedPositioned(
                curve: Curves.easeInToLinear,
                duration: const Duration(seconds: 1),
                top: signUpController.loginType.value == "LoginIn"
                    ? 370.h
                    : 320.h,
                child: Container(
                    height: 492.h,
                    width: 375.w,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Obx(() {
                      print("${signUpController.loginType.value} -----------");
                      return signUpController.loginType.value == "LoginIn"
                          ? LoginIn()
                          : SignUp();
                    })),
              );
            }),
          ],
        ),
      ),
    );
  }
}
