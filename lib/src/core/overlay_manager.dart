import 'package:flutter/material.dart';

class OverlayManager {
  OverlayEntry? _entry;

  bool get isShowing => _entry != null;

  OverlayEntry? get entry => _entry;

  void show(BuildContext context, OverlayEntry entry) {
    hide();

    _entry = entry;

    Overlay.of(context).insert(entry);
  }

  void hide() {
    _entry?.remove();

    _entry = null;
  }

  void rebuild() {
    _entry?.markNeedsBuild();
  }
}
