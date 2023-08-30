import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/views/ui/controller/sign_up_controller.dart';

import '../../auth.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().singInWithEmailPass(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          style: const TextStyle(color: Colors.white),
          controller: _controllerEmail,
          decoration: InputDecoration(
            label: const Text("Email"),
            labelStyle: const TextStyle(color: Colors.grey),
            // focusedBorder: InputBorder.none,
            hintText: 'Enter your mail',
            hintStyle: TextStyle(color: Colors.grey.shade300),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors
                    .grey, // Change this color to your desired underline color
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1, // You can adjust the width of the underline
                color: Colors
                    .grey, // Change this color to your desired underline color
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          controller: _controllerPassword,
          decoration: InputDecoration(
            label: const Text("Password"),
            labelStyle: const TextStyle(color: Colors.grey),
            hintText: 'Enter your password',
            hintStyle: TextStyle(color: Colors.grey.shade300),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.w,
                color: Colors
                    .grey, // Change this color to your desired underline color
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.w, // You can adjust the width of the underline
                color: Colors
                    .grey, // Change this color to your desired underline color
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          children: [
            Container(
              width: 222.w,
            ),
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFFFF822C),
              ),
            )
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        GestureDetector(
          onTap: () {
            signInWithEmailAndPassword();
            // setState(() {
            //   if (signUpController.loginType.value == "LoginIn") {
            //     signUpController.updateLoginType("SignUp");
            //   } else {
            //     signUpController.updateLoginType("LoginIn");
            //   }
            // });
          },
          child: Container(
            height: 60.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFF822C),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?  ",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.grey.shade400,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (signUpController.loginType.value == "LoginIn") {
                    signUpController.updateLoginType("SignUp", 2);
                  }
                });
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Color(0xFFFF822C),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Container(
              width: 123,
              height: 1,
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              width: 3,
            ),
            Text("or continue with",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                )),
            const SizedBox(
              width: 3,
            ),
            Container(
              width: 123,
              height: 1,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          width: 30,
          child: Image.asset("assets/icons/google.png"),
        )
      ],
    );
  }
}
