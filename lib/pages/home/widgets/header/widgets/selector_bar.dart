import 'package:flutter/material.dart';

import 'package:ethller/widgets/common/buttons/gradient_button.dart';

class SelectorBar extends StatelessWidget {
  final List<SelectorBarButton> items;

  const SelectorBar({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double totalWidth = items.length * 107.5 + 2.5;

    return Container(
      height: 50,
      width: totalWidth,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFF292a50),
        borderRadius: BorderRadius.circular(30),
      ),
      child: _ButtonBar(items: items),
    );
  }
}

class _ButtonBar extends StatefulWidget {
  final List<SelectorBarButton> items;

  const _ButtonBar({
    @required this.items,
  });

  @override
  __ButtonBarState createState() => __ButtonBarState();
}

class __ButtonBarState extends State<_ButtonBar> {
  double xOffset = 0;
  final List<Widget> buttons = [];

  @override
  void initState() {
    _RowButton rb = _RowButton(title: '', onPressed: () {});

    int i = 1;
    for (SelectorBarButton button in widget.items) {
      final double xx = i * 107.5 - 107.5;

      rb = _RowButton(
        title: button.title,
        onPressed: () {
          setState(() {
            xOffset = xx;
          });
          button.onPressed();
        },
      );

      buttons.add(rb);

      i++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: xOffset,
            curve: Curves.easeIn,
            child: GradientButton(
              width: 100,
              height: 40,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...buttons],
          ),
        ],
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const _RowButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        width: 100,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class SelectorBarButton {
  final String title;
  final Function onPressed;

  SelectorBarButton({
    this.title,
    this.onPressed,
  });
}
