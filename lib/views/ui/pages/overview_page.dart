import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/download_manager_controller.dart';
import 'package:newiet/views/ui/controller/overview_controller.dart';
import 'package:newiet/views/ui/pages/downloadPage.dart';
import 'package:newiet/views/ui/pages/setting_page.dart';
import 'package:newiet/views/widgetsd/overview_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class OverView extends StatefulWidget {
  const OverView({super.key});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("SignOut"));
  }

  List<String> fileHeader = [
    "Files",
    "Documents",
    "Images",
    "Hello",
    "Videos",
    "Audio",
    "Video",
    "Image",
    "Document",
  ];
  List<Color> _getGradientColors() {
    List<Color> colors = [];

    // Define color stops and corresponding colors based on file sizes
    colors.add(Colors.red); // Red for 0-10%
    colors.add(Colors.red); // Red for 0-10%
    colors.add(Colors.green); // Green for 11-30%
    colors.add(Colors.green); // Green for 11-30%
    // Add more colors and color stops for different ranges

    return colors;
  }

  List<Color> colorsProject = [
    const Color(0xFFA5C9CA),
    const Color(0xFFECDBBA),
    const Color(0xFFD8E9A8),
    const Color(0xFFC4BBF0),
    const Color(0xFF90B8F8),
    const Color(0xFFDECE9C),
  ];
  List<Color> colorsArc = [
    const Color.fromARGB(255, 233, 92, 106),
    const Color.fromARGB(255, 252, 188, 111),
    const Color(0xFF1C536B),
  ];
  List<Color> colorsFiles = [
    const Color(0xFFDECE9C),
    const Color(0xFFD8E9A8),
    const Color(0xFFC4BBF0),
    const Color(0xFFA5C9CA),
    const Color(0xFFECDBBA),
    const Color(0xFF90B8F8),
  ];

  var downloadManagerController = Get.put(DownloadManagerController());

  List<Widget> _createChildren() {
    return List<Widget>.generate(4, (int index) {
      return Text("someList[index]".toString());
    });
  }

  final OverViewController _overViewController = Get.put(OverViewController());

  void _showAddDialog(BuildContext context) {
    String newName = "";
    double newValue = 0.0;
    DateTime newDate = DateTime.now();

    final nameController = TextEditingController();
    final valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFfefae0),
          title: Text("Add Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  newName = value;
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  errorText: newName.length < 3 ? 'Enter a valid name' : null,
                ),
              ),
              TextField(
                controller: valueController,
                onChanged: (value) {
                  newValue = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(
                  labelText: "Value",
                  errorText: newValue < 3 ? 'Enter a valid value' : null,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Text("Date: ${DateFormat('yyyy-MM-dd').format(newDate)}",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  newDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  ))!;
                  if (newDate == null) {
                    newDate = DateTime.now();
                  }
                },
                child: Text("Select Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newName.length >= 3 && newValue >= 3) {
                  _overViewController.addDataItem(newName, newValue, newDate);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("EdgeRev",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24)),
        // backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text("Hello,",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                  // SizedBox(
                  //   width: 3,
                  // ),
                  Text(" Kartikey!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                ],
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 55, 167, 165),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    MultiColorCircularProgressIndicator(
                      radius: 50.0,
                      lineWidth: 13.0,
                      colors: [
                        const Color.fromARGB(255, 233, 92, 106),
                        const Color.fromARGB(255, 252, 188, 111),
                        const Color(0xFF1C536B),
                      ],
                      colorStops: [
                        0.0,
                        0.90,
                        1.6,
                        2.5,
                      ], // Adjust stops as needed
                      percent: 0.3,
                      centerText: "76%",
                      textSize:
                          20.0, // Adjust this value dynamically based on your file size
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Sample Project 1!",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "73 GB of 100 GB used",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 20,
                          width: 213,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: colorsArc[index],
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    fileHeader[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text(
                    "Projects",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: null,
                      child: Row(
                        children: [
                          const Text(
                            "View all",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Button(
                            icon: Icons.arrow_forward_ios,
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {},
                          ),
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Container(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: _overViewController.dataList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return (_overViewController.dataList.length == index)
                        ? GestureDetector(
                            onTap: () {
                              _showAddDialog(context);
                            },
                            child: Container(
                              width: 138,
                              height: 100,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // border: Border.all(),
                                color: colorsProject[index],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.add, size: 30),
                            ),
                          )
                        : Container(
                            width: 138,
                            height: 100,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: colorsProject[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _overViewController.dataList[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 37, 37, 37),
                                    fontSize: 14.sp,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                MultiColorCircularProgressIndicator(
                                    radius: 30.0,
                                    lineWidth: 8.0,
                                    colors: [
                                      const Color.fromARGB(255, 233, 92, 106),
                                      const Color.fromARGB(255, 252, 188, 111),
                                      const Color(0xFF1C536B),
                                    ],
                                    colorStops: [
                                      0.0 * random.nextDouble(),
                                      0.90 * random.nextDouble(),
                                      1.6 * random.nextDouble(),
                                      2.5 * random.nextDouble(),
                                    ], // Adjust stops as needed
                                    percent: 0.3,
                                    centerText:
                                        "${(random.nextDouble() * 100).floor()}%",
                                    textSize:
                                        14 // Adjust this value dynamically based on your file size
                                    ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "17/08/2023",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 37, 37, 37),
                                    fontSize: 12.sp,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                  },
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text(
                    "Files",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: null,
                    child: Row(
                      children: [
                        const Text(
                          "View all",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Button(
                          icon: Icons.arrow_forward_ios,
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 290,
                width: double.infinity,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: fileHeader.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          downloadManagerController.currentIndex.value = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DownloadPage(
                                  title: fileHeader[
                                      index]), // Replace with the screen you want to navigate to
                            ),
                          );
                        },
                        child: Container(
                            height: 55,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colorsFiles[index],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  fileHeader[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    width: 5,
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            )),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiColorCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final List<Color> colors;
  final List<double> colorStops;
  final double percent;

  final String centerText;
  final double textSize;

  MultiColorCircularProgressIndicator({
    required this.radius,
    required this.lineWidth,
    required this.colors,
    required this.colorStops,
    required this.percent,
    required this.centerText,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: _MultiColorProgressPainter(
            radius: radius,
            lineWidth: lineWidth,
            colors: colors,
            colorStops: colorStops,
            percent: percent,
          ),
          size: Size.fromRadius(radius),
        ),
        Text(
          centerText,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Customize text color
          ),
        ),
      ],
    );
  }
}

class _MultiColorProgressPainter extends CustomPainter {
  final double radius;
  final double lineWidth;
  final List<Color> colors;
  final List<double> colorStops;
  final double percent;

  _MultiColorProgressPainter({
    required this.radius,
    required this.lineWidth,
    required this.colors,
    required this.colorStops,
    required this.percent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percent;

    var currentAngle = startAngle;
    for (int i = 0; i < colors.length; i++) {
      final sweep = sweepAngle * (colorStops[i + 1] - colorStops[i]);
      final arcPaint = Paint()
        ..color = colors[i]
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweep,
        false,
        arcPaint,
      );

      currentAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Button extends StatelessWidget {
  const Button({
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
        height: 20.h,
        width: 20.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF415a77),
          borderRadius: borderRadius,
        ),
        child: Icon(
          icon,
          size: 12.w,
          color: const Color(0xFFe0e1dd),
        ),
      ),
    );
  }
}
