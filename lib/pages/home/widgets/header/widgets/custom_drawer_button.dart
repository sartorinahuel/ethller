import 'dart:math';

import 'package:flutter/material.dart';

class CustomDrawerButton extends StatefulWidget {
  final Function onPressed;
  final bool isOpen;

  const CustomDrawerButton({
    Key key,
    this.onPressed,
    this.isOpen = false,
  }) : super(key: key);

  @override
  _CustomDrawerButtonState createState() => _CustomDrawerButtonState();
}

class _CustomDrawerButtonState extends State<CustomDrawerButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _rotarIzquierda;
  Animation<double> _rotarDerecha;
  Animation<double> _subir;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _rotarDerecha = Tween(begin: pi, end: pi * 1.25)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _rotarIzquierda = Tween(begin: pi, end: pi * 0.75)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _subir = Tween(begin: 0.0, end: 5.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) {
      _controller.reset();
    }
    return GestureDetector(
      onTap: () {
        if (widget.isOpen) {
          _controller.reverse(from: 1.0);
        } else {
          _controller.forward(from: 0.0);
        }
        widget.onPressed();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Container(
                width: 22,
                height: 15,
                child: Stack(
                  children: [
                    Positioned(
                      top: _subir.value,
                      child: Transform.rotate(
                        angle: _rotarDerecha.value,
                        child: _ButtonLine(),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      child: Transform.rotate(
                        angle: _rotarIzquierda.value,
                        child: _ButtonLine(),
                      ),
                    ),
                    Positioned(
                      top: 10 - _subir.value,
                      child: Transform.rotate(
                        angle: _rotarIzquierda.value,
                        child: _ButtonLine(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ButtonLine extends StatelessWidget {
  const _ButtonLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 22,
      child: CustomPaint(
        painter: _CustomDrawerButtonLine(),
      ),
    );
  }
}

class _CustomDrawerButtonLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //painter
    final paint = new Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = new Path();

    path.moveTo(0, 1);
    path.lineTo(22, 1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomDrawerButtonLine oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CustomDrawerButtonLine oldDelegate) => false;
}
