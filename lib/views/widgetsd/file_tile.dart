import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newiet/views/ui/pages/downloadPage.dart';

class FileTile extends StatelessWidget {
  FileTile({required this.fileHeader});
  String fileHeader;
  @override
  Widget build(BuildContext context) {
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
        height: 10,
        width: 2,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        child: Row(
          children: [
            // Container(
            //   child: Image.asset('assets/icons/folder.png'),
            // ),
            SizedBox(
              width: 15.w,
            ),
            Container(
              child: Text(
                fileHeader,
                style: TextStyle(
                  color: Color(0xFFe0e1dd),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18.sp,
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
