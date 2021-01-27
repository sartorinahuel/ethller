import 'package:flutter/material.dart';

import '../custom_backgrounds.dart';

class CompanionButton extends StatelessWidget {
  const CompanionButton({
    @required this.isSelected,
    @required this.onPressed,
    @required this.text,
  });

  final bool isSelected;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isSelected)
          ClipRRect(
            child: Container(
              height: 30,
              width: 40,
              child: GradientBackground(),
            ),
          ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 30,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.transparent : Color(0xFF363663),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
