import 'package:flutter/material.dart';

class AnimatedAppBar extends StatefulWidget {
  AnimatedAppBar({
    super.key,
    required this.selected1,
    required this.selected2,
    required this.selected3,
  });
  bool selected1;
  bool selected2;
  bool selected3;
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar> {
  // bool selected1 = true;
  // bool selected2 = true;
  // bool selected3 = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          width: 310.0,
          height: 210.0,
          // top: selected ? 50.0 : 150.0,
          left: -50,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.selected1 = !widget.selected1;
              });
            },
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(17.33 / 360),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151311),
                  borderRadius: BorderRadius.circular(140),
                ),
                child: Center(
                  child: AnimatedOpacity(
                    opacity: widget.selected1 ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-17.33 / 360),
                      child: Text(
                        'OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          width: 310.0,
          height: 210.0,
          // top: selected ? 50.0 : 150.0,
          left: widget.selected2 ? 70 : 140,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.selected2 = !widget.selected2;
              });
            },
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(17.33 / 360),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF822C),
                  borderRadius: BorderRadius.circular(140),
                ),
                child: Center(
                  child: AnimatedOpacity(
                    opacity: widget.selected2 ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-17.33 / 360),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          width: 310.0,
          height: 210.0,
          // top: selected ? 50.0 : 150.0,
          left: widget.selected3 ? 160 : 270,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.selected3 = !widget.selected3;
              });
            },
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(17.33 / 360),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151311),
                  borderRadius: BorderRadius.circular(140),
                ),
                child: Center(
                  child: AnimatedOpacity(
                    opacity: widget.selected3 ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-17.33 / 360),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
