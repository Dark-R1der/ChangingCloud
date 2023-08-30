import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/authentication.dart';
import 'package:newiet/views/ui/pages/home.dart';
import 'firebase_options.dart';
import 'package:flutter_test/flutter_test.dart'; // Import necessary testing package

import 'views/ui/pages/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Changing Cloud',
            theme: ThemeData(
              textTheme: TextTheme(
                titleMedium: TextStyle(color: Colors.red),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(14, 11, 31, 47),
                primary: Color(0xFF0E0B1F),
                secondary: Color(0xFFCBFB5E),
              ),
            ),
            home: Authentication()
            // home: StreamBuilder(
            //     stream: FirebaseAuth.instance.authStateChanges(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return HomePage();
            //       } else {
            //         return SignUpPage();
            //       }
            //     }),
            );
      },
    );
  }
}
