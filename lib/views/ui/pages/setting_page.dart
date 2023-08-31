import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  List<Color> colorGrid = [
    Color(0xFFb56576),
    Color(0xFF355070),
    Color(0xFF6d597a),
    Color(0xFFe56b6f),
    Color(0xFFeaac8b),
    Color(0xFFb56576),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1b263b),
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
            SettingTiles(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: ( / 2),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: 4, // Number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorGrid[index],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sample Project 1",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          width: 132.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          leading: new Text("0"),
                          trailing: new Text("100"),
                          percent: 0.4,
                          center: Text("20.0%"),
                          barRadius: const Radius.circular(16),
                          progressColor: Colors.red,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          width: 132.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          leading: new Text("0"),
                          trailing: new Text("100"),
                          percent: 0.4,
                          center: Text("20.0%"),
                          barRadius: const Radius.circular(16),
                          progressColor: Colors.red,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          width: 132.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          leading: new Text("0"),
                          trailing: new Text("100"),
                          percent: 0.4,
                          center: Text("20.0%"),
                          barRadius: const Radius.circular(16),
                          progressColor: Colors.red,
                        ),
                        Text(
                          "Sample Project 1",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingTiles extends StatelessWidget {
  const SettingTiles({
    super.key,
  });

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
                "Max Number of File",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
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
        Container(
          padding: const EdgeInsets.all(14.0),
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15.w)),
          child: Row(
            children: [
              Text(
                "Budget",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
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
        Container(
          padding: const EdgeInsets.all(14.0),
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15.w)),
          child: Row(
            children: [
              Text(
                "BandWidth",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
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
        )
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
