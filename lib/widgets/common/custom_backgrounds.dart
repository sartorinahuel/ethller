import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final double width;
  final double height;
  final bool isButton;

  const GradientBackground({
    Key key,
    this.width = 150,
    this.height = 150,
    this.isButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          isButton ? BorderRadius.circular(50) : BorderRadius.circular(1000),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: isButton ? BoxShape.rectangle : BoxShape.circle,
          color: Color(0xFF154dfe),
        ),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: -70,
                left: isButton ? -80 : -50,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF16b5fe),
                        blurRadius: 160,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: -90,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFdf29eb),
                        blurRadius: 160,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomContainer extends StatelessWidget {
//   final double height;
//   final double width;
//   final Widget child;
//   final double borderRadius;
//   final EdgeInsets padding;
//   final EdgeInsets margin;

//   const CustomContainer({
//     Key key,
//     this.height = 100,
//     this.width = double.infinity,
//     this.child,
//     this.borderRadius = 30,
//     this.padding = const EdgeInsets.only(top: 10),
//     this.margin = const EdgeInsets.all(10),
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: padding,
//       margin: margin,
//       decoration: BoxDecoration(
//         color: Color(0xFF202143),
//         borderRadius: BorderRadius.all(
//           Radius.circular(borderRadius),
//         ),
//       ),
//       child: child != null ? child : Container(),
//     );
//   }
// }
