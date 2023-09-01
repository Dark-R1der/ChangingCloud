import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/firestorestuff.dart';
import 'package:newiet/views/ui/controller/download_manager_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NodePage extends StatefulWidget {
  const NodePage({super.key});

  @override
  State<NodePage> createState() => _NodePageState();
}

class _NodePageState extends State<NodePage> {
  DownloadManagerController _downloadManagerController =
      Get.put(DownloadManagerController());
  var firebaseStory = Get.put(FirestoreStory());
  @override
  void initState() {
    // TODO: implement initState
    firebaseStory
        .checkAndDownloadFiles(FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var revenue = _downloadManagerController.individualSizes[0] +
        (_downloadManagerController.individualSizes[1] +
                _downloadManagerController.individualSizes[2] +
                _downloadManagerController.individualSizes[3]) *
            0.001;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Node",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24.sp)),
        // backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: 180.0,
                lineWidth: 13.0,
                animation: true,
                percent: revenue / 0.0001,
                center: Text(
                  "${(revenue / 0.001).toString()}%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                footer: Text(
                  "Total revenue: $revenue ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
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
