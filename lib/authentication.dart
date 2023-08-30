
import 'package:flutter/material.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/pages/home.dart';
import 'package:newiet/views/ui/pages/sign_up.dart';

class Authentication extends StatelessWidget {
  const Authentication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return SignUpPage();
        }
      },
    );
  }
}
