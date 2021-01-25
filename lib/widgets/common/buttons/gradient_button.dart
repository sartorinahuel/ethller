import 'package:flutter/material.dart';

import '../custom_backgrounds.dart';

class GradientButton extends StatelessWidget {
  final double width;
  final double height;
  final bool isButton;
  final Widget child;
  final Function onPressed;

  const GradientButton({
    Key key,
    this.width = 100,
    this.height = 100,
    this.isButton = true,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            GradientBackground(
              isButton: isButton,
              height: height,
              width: width,
            ),
            Center(child: child),
          ],
        ),
      ),
    );
  }
}