import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/views/ui/controller/dowload_controller.dart';
import 'package:newiet/views/widgetsd/download_tile.dart';
import 'package:newiet/views/widgetsd/file_tile.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({super.key, required this.title});
  String title;
  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.cloud_upload_rounded,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            return DownloadTile(fileHeader: "File Name");
          },
        ),
      ),
    );
  }
}
