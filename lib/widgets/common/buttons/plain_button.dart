import 'package:flutter/material.dart';

class PlainButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final double width;
  final IconData icon;
  final String title;

  const PlainButton({
    Key key,
    this.onPressed,
    this.height = 50,
    this.width = 100,
    this.icon,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFF202143),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 20)
            : Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}