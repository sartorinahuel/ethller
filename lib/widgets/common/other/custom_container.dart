import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const CustomContainer({
    Key key,
    this.height = 100,
    this.width = double.infinity,
    this.child,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.only(top: 10),
    this.margin = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Color(0xFF202143),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: child != null ? child : Container(),
    );
  }
}
