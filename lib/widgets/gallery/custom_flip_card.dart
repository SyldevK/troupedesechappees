import 'dart:math' as math;

import 'package:flutter/cupertino.dart';


class CustomFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const CustomFlipCard({super.key, required this.front, required this.back});

  @override
  State<CustomFlipCard> createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomFlipCard> {
  bool _flipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _flipped = !_flipped),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          final rotate = Tween(begin: math.pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(_flipped) != child!.key);
              final angle = isUnder ? math.pi - rotate.value : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(angle),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        child: _flipped
            ? Container(key: const ValueKey(true), child: widget.back)
            : Container(key: const ValueKey(false), child: widget.front),
      ),
    );
  }
}
