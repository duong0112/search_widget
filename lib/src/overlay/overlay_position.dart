import 'package:flutter/material.dart';

class OverlayPosition {
  const OverlayPosition({
    required this.offset,
    required this.showAbove,
    required this.width,
    required this.height,
  });

  final Offset offset;

  final bool showAbove;

  final double width;

  final double height;

  static OverlayPosition calculate({
    required BuildContext context,
    required RenderBox target,
    double dropdownHeight = 300,
  }) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final size = target.size;

    final position = target.localToGlobal(Offset.zero);

    final spaceBelow = screenHeight - (position.dy + size.height);

    final showAbove = spaceBelow < dropdownHeight;

    return OverlayPosition(
      width: size.width,
      height: dropdownHeight,
      showAbove: showAbove,
      offset: showAbove ? Offset(0, -dropdownHeight) : Offset(0, size.height),
    );
  }
}
