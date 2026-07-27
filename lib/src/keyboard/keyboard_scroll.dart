import 'package:flutter/widgets.dart';

class KeyboardScroll {
  static void scrollTo(
      ScrollController controller,
      int index,
      double itemExtent,
      ) {

    final offset =
        index * itemExtent;

    if (!controller.hasClients) {
      return;
    }

    controller.animateTo(
      offset,
      duration: const Duration(
        milliseconds: 150,
      ),
      curve: Curves.easeOut,
    );
  }
}