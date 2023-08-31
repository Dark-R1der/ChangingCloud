import 'package:flutter/material.dart';
import 'package:newiet/views/ui/controller/page_controller.dart';
import 'package:newiet/views/widgetsd/buttom_nav_widget.dart';

class BottomNavButton extends StatelessWidget {
  BottomNavButton({
    super.key,
  });
  PageControl pageControl = PageControl();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            BottomNavWidget(
              onTap: () {
                pageControl.index.value = 0;
                print("Index value = ${pageControl.index.value}");
              },
              icon: Icons.public,
            ),
            BottomNavWidget(
              onTap: () {
                pageControl.index.value = 1;
                print("Index value = ${pageControl.index.value}");
              },
              icon: Icons.settings,
            ),
          ],
        ),
      ),
    ));
  }
}
