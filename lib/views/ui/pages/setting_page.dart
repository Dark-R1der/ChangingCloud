import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  List<Color> colorGrid = [
    const Color(0xFFb56576),
    const Color(0xFF355070),
    const Color(0xFF6d597a),
    const Color(0xFFe56b6f),
    const Color(0xFFeaac8b),
    const Color(0xFFb56576),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Setting",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24.sp)),
        // backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Setting",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            SettingTiles(title: "Max Number of files"),
            SettingTiles(title: "BandWidth (in GB)"),
            SettingTiles(title: "Budget"),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "In Development",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            SettingTiles(title: "Number of peers"),
          ],
        ),
      ),
    );
  }
}

class SettingTiles extends StatelessWidget {
  SettingTiles({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15.w)),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 70.w,
                ),
              ),
              HalfRoundButton(
                icon: Icons.remove,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                onTap: () {},
              ),
              Container(
                width: 60,
                height: 32,
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: const Text(
                  "02",
                ),
              ),
              HalfRoundButton(
                icon: Icons.add,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

class HalfRoundButton extends StatelessWidget {
  const HalfRoundButton({
    Key? key,
    required this.icon,
    required this.borderRadius,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 29.h,
        width: 30.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF415a77),
          borderRadius: borderRadius,
        ),
        child: Icon(
          icon,
          size: 20.w,
          color: const Color(0xFFe0e1dd),
        ),
      ),
    );
  }
}
