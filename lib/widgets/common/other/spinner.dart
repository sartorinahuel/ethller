import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class SpinnerIndicator extends StatefulWidget {
  final int denominator;
  final int numerator;
  final double radius;
  final bool showCenterData;

  const SpinnerIndicator({
    Key key,
    @required this.denominator,
    @required this.numerator,
    this.radius = 50,
    this.showCenterData = true,
  }) : super(key: key);

  @override
  _SpinnerIndicatorState createState() => _SpinnerIndicatorState();
}

class _SpinnerIndicatorState extends State<SpinnerIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _spin;
  int speed = 300;

  @override
  void initState() {
    if (widget.numerator == widget.denominator) {
      speed = 300;
      if (widget.numerator == 0) {
        speed = 0;
      }
    } else if (widget.numerator == 0) {
      speed = 0;
    } else {
      speed = 700;
    }

    _controller = new AnimationController(
        duration: Duration(milliseconds: speed), vsync: this);

    _spin = Tween(begin: 0.0, end: 90.0).animate(_controller);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.numerator == widget.denominator) {
      speed = 300;
      if (widget.numerator == 0) {
        speed = 0;
      }
    } else if (widget.numerator == 0) {
      speed = 0;
    } else {
      speed = 700;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(from: 0.0);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: widget.radius,
          width: widget.radius,
          child: Stack(
            children: [
              widget.showCenterData
                  ? Container(
                      height: widget.radius,
                      width: widget.radius,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            widget.numerator.toString(),
                            maxFontSize: 17,
                            minFontSize: 10,
                            maxLines: 1,
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          if (widget.numerator <= 99)
                            Text(
                              '/${widget.denominator.toString()}',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                height: widget.radius,
                width: widget.radius,
                child: CustomPaint(
                  painter: _BorderPainter(_spin.value, speed),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BorderPainter extends CustomPainter {
  double animatedValue;
  int speed;

  _BorderPainter(this.animatedValue, this.speed);

  @override
  void paint(Canvas canvas, Size size) {
    //painter
    final painter = new Paint();

    painter
      ..color = speed == 300
          ? Colors.green
          : speed == 0
              ? Colors.red
              : Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //draw

    final center = new Offset(size.width * 0.5, size.height / 2);
    final radio = min(size.width * 0.5, size.height * 0.5);

    double arcAngle = 2 * pi * 0.15;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radio),
        (270 + animatedValue) * (pi / 0180), arcAngle, false, painter);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio),
        (0 + animatedValue) * (pi / 0180), arcAngle, false, painter);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio),
        (90 + animatedValue) * (pi / 0180), arcAngle, false, painter);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio),
        (180 + animatedValue) * (pi / 0180), arcAngle, false, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
