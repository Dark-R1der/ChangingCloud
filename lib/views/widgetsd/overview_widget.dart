import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/sign_up_controller.dart';
import 'package:newiet/views/widgetsd/file_tile.dart';

class OverviewWidget extends StatefulWidget {
  const OverviewWidget({super.key});

  @override
  State<OverviewWidget> createState() => _OverviewWidgetState();
}

List<String> fileHeader = [
  "Files",
  "Documents",
  "Images",
  "Hello",
  "Videos",
  "Audio",
];

class _OverviewWidgetState extends State<OverviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.w),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (7 / 2),
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: fileHeader.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return FileTile(
            fileHeader: fileHeader[index],
          );
        },
      ),
    );
  }
}
