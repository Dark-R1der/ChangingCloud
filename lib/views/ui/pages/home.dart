import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newiet/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Text("Firebase Auth");
  }

  Widget _userUid() {
    return Text(user?.email ?? "User email");
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: Text("SignOut"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        child: Column(children: [
          _userUid(),
          _signOutButton(),
        ]),
      ),
    );
  }
}
