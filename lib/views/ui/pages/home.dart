import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/page_controller.dart';
import 'package:newiet/views/ui/pages/overview_page.dart';
import 'package:newiet/views/ui/pages/setting_page.dart';
import 'package:newiet/views/widgetsd/buttom_nav_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  final PageControl pageControl = Get.put(PageControl());

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _userUid() {
    return Text(user?.email ?? "User email");
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("SignOut"));
  }

  List<Widget> pageList = [
    const OverView(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Obx(() {
        return pageControl.index.value == 0 ? OverView() : SettingPage();
      }),
      bottomNavigationBar: BottomNavButton(),
    );
  }
}
