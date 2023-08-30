import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/sign_up_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final SignUpController signUpController = Get.put(SignUpController());
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        role: signUpController.dropdownValue.value,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          controller: _controllerName,
          decoration: InputDecoration(
            label: const Text("Name"),
            labelStyle: const TextStyle(color: Colors.grey),
            // focusedBorder: InputBorder.none,
            hintText: 'Enter your name',
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
          height: 20.h,
        ),
        Obx(
          () => DropdownButton<String>(
            isExpanded: true,
            value: signUpController.dropdownValue.value, // Selected value
            onChanged: (String? newValue) {
              signUpController.dropdownValue.value = newValue!;
            },
            items: <String>['Node', 'Organization']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: () {
            // print("Hello");
            // setState(() {
            //   if (signUpController.loginType.value == "LoginIn") {
            //     signUpController.updateLoginType("SignUp");
            //   } else {
            //     signUpController.updateLoginType("LoginIn");
            //   }
            // });
          },
          child: GestureDetector(
            onTap: () {
              createUserWithEmailAndPassword();
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
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (signUpController.loginType.value == "SignUp") {
                signUpController.updateLoginType("LoginIn", 0);
              }
            });
          },
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF822C),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
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
        const SizedBox(
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
