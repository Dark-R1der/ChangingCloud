import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/page_controller.dart';
import 'package:newiet/views/ui/pages/overview_page.dart';
import 'package:newiet/views/ui/pages/setting_page.dart';
import 'package:newiet/views/widgetsd/buttom_nav_button.dart';

import '../../../firestorestuff.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  final PageControl pageControl = Get.put(PageControl());
  var firebaseStory = Get.put(FirestoreStory());
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    firebaseStory
        .checkAndDownloadFiles(FirebaseAuth.instance.currentUser!.email!);

    super.initState();
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
  int pageIndex = 0;
  final pages = [
    const OverView(),
    SettingPage(),
  ];

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context));
  }
}
