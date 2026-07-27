import 'package:flutter/material.dart';

class OverlayAnimation extends StatelessWidget {
  const OverlayAnimation({super.key, required this.child, required this.animation});

  final Widget child;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(sizeFactor: animation, axisAlignment: -1, child: child),
    );
  }
}
