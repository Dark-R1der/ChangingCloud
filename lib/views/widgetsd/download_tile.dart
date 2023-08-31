import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newiet/views/ui/controller/dowload_controller.dart';
import 'package:newiet/views/ui/pages/downloadPage.dart';

class DownloadTile extends StatelessWidget {
  DownloadTile({required this.fileHeader});
  String fileHeader;
  @override
  Widget build(BuildContext context) {
    final DownloadController downloadController = Get.put(DownloadController());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DownloadPage(
                title:
                    fileHeader), // Replace with the screen you want to navigate to
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Image(
                image: NetworkImage(
                  'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Container(
              child: Text(
                fileHeader,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () {
                      return downloadController.loading.value
                          ? Container(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black,
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 26.sp,
                            );
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
