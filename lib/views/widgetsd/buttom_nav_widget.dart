import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key, this.icon, this.onTap});
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 179,
        height: 40,
        child: SizedBox(
          height: 36,
          width: 36,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
