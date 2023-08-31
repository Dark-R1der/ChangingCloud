import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/firestorestuff.dart';
import 'package:newiet/views/ui/controller/dowload_controller.dart';
import 'package:newiet/views/ui/controller/download_manager_controller.dart';
import 'package:newiet/views/widgetsd/download_tile.dart';
import 'package:newiet/views/widgetsd/file_tile.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({super.key, required this.title});
  String title;
  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  var firebaseStory = Get.find<FirestoreStory>();
  var downloadManagerController = Get.find<DownloadManagerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.cloud_upload_rounded),
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path!);
                  downloadManagerController.currentOccupied.value +=
                      file.lengthSync();
                  downloadManagerController.individualSizes[
                          downloadManagerController.currentIndex.value] +=
                      file.lengthSync();
                  downloadManagerController.currentFiles.value += 1;
                  final filePath = file.path;
                  final List<String> pathParts = filePath.split('/');
                  final extractedFileName = pathParts.last;
                  if (downloadManagerController.currentIndex.value == 0) {
                    downloadManagerController.documentStuff
                        .add(extractedFileName);
                  } else if (downloadManagerController.currentIndex.value ==
                      1) {
                    downloadManagerController.imagesStuff
                        .add(extractedFileName);
                  } else if (downloadManagerController.currentIndex.value ==
                      2) {
                    downloadManagerController.videosStuff
                        .add(extractedFileName);
                  } else if (downloadManagerController.currentIndex.value ==
                      3) {
                    downloadManagerController.audioStuff.add(extractedFileName);
                  }

                  await firebaseStory.uploadAndDistribute(
                      1, FirebaseAuth.instance.currentUser!.email!, file);
                }
              },
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
