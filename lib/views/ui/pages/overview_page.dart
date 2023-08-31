import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/auth.dart';
import 'package:newiet/views/ui/controller/download_manager_controller.dart';
import 'package:newiet/views/ui/pages/downloadPage.dart';
import 'package:newiet/views/ui/pages/setting_page.dart';
import 'package:newiet/views/widgetsd/overview_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    "Documents",
    "Images",
    "Videos",
    "Audio",
  ];

  var downloadManagerController = Get.put(DownloadManagerController());

  List<Widget> _createChildren() {
    return List<Widget>.generate(4, (int index) {
      return Text("someList[index]".toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clund"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Hello,",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20)),
                  // SizedBox(
                  //   width: 3,
                  // ),
                  Text(" Kartikey!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 13.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: 0.6,
                      center: Text("100%"),
                      progressColor: Colors.green,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sample Project 1!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "73 GB of 100 GB used",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Projects",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: null,
                      child: Row(
                        children: [
                          Text(
                            "View all",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 138,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sample Project ${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LinearPercentIndicator(
                            width: 110.0,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 12.0,
                            // leading: new Text("0"),
                            // trailing: new Text("100"),
                            percent: 0.4,
                            // center: Text("20.0%"),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LinearPercentIndicator(
                            width: 110.0,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 12.0,
                            // leading: new Text("0"),
                            // trailing: new Text("100"),
                            percent: 0.4,
                            // center: Text("20.0%"),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LinearPercentIndicator(
                            width: 110.0,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 12.0,
                            // leading: new Text("0"),
                            // trailing: new Text("100"),
                            percent: 0.4,
                            // center: Text("20.0%"),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "17/08/2023",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Files",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: null,
                    child: Row(
                      children: [
                        Text(
                          "View all",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 290,
                width: double.infinity,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
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
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  fileHeader[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 5,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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


// return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "OverView",
//         ),
//         actions: [
//           _signOutButton(),
//         ],
//       ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(50),
//                 height: 712,
//                 width: 412,
//                 color: const Color(0xFF1b263b),
//               ),
//               Positioned(
//                 top: 100,
//                 left: 50,
//                 child: Container(
//                   height: 300,
//                   width: 300,
//                   child: SfRadialGauge(
//                     axes: <RadialAxis>[
//                       RadialAxis(
//                         ranges: <GaugeRange>[
//                           GaugeRange(
//                               startValue: 0,
//                               endValue: 200,
//                               sizeUnit: GaugeSizeUnit.factor,
//                               startWidth: 0.03,
//                               endWidth: 0.03,
//                               gradient: const SweepGradient(colors: <Color>[
//                                 Colors.green,
//                                 Colors.yellow,
//                                 Colors.red
//                               ], stops: <double>[
//                                 0.0,
//                                 0.5,
//                                 1
//                               ]))
//                         ],
//                         annotations: <GaugeAnnotation>[
//                           GaugeAnnotation(
//                               widget: Container(
//                                   child: const Column(children: <Widget>[
//                                 SizedBox(
//                                   height: 120,
//                                 ),
//                                 Text("150",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 5),
//                                 Text('files',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))
//                               ])),
//                               angle: 90,
//                               positionFactor: 0.75)
//                         ],
//                         pointers: const <GaugePointer>[
//                           NeedlePointer(
//                               value: 150,
//                               needleLength: 0.95,
//                               enableAnimation: true,
//                               animationType: AnimationType.ease,
//                               needleStartWidth: 1.5,
//                               needleEndWidth: 6,
//                               needleColor: Colors.red,
//                               knobStyle: KnobStyle(knobRadius: 0.09))
//                         ],
//                         minimum: 0,
//                         maximum: 200,
//                         labelOffset: 30,
//                         axisLineStyle: const AxisLineStyle(
//                             thicknessUnit: GaugeSizeUnit.factor,
//                             thickness: 0.03),
//                         majorTickStyle: const MajorTickStyle(
//                             length: 6, thickness: 4, color: Colors.white),
//                         minorTickStyle: const MinorTickStyle(
//                             length: 3, thickness: 3, color: Colors.white),
//                         axisLabelStyle: const GaugeTextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 100,
//               // ),
//               Positioned(
//                 bottom: -180.h,
//                 child: SizedBox(
//                   height: 400.h,
//                   width: 375.w,
//                   child: const OverviewWidget(),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
