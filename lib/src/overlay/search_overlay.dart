import 'package:flutter/material.dart';

import '../core/overlay_manager.dart';
import 'overlay_position.dart';

class SearchOverlay {
  SearchOverlay({
    required this.context,
    required this.layerLink,
    required this.overlayManager,
  });

  final BuildContext context;

  final LayerLink layerLink;

  final OverlayManager overlayManager;

  OverlayEntry create({
    required Widget Function() overlayBuilder,
    required RenderBox target,
    double height = 300,
  }) {
    final position =
    OverlayPosition.calculate(
      context: context,
      target: target,
      dropdownHeight: height,
    );

    return OverlayEntry(
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior:
                HitTestBehavior
                    .translucent,
                onTap: () {
                  FocusManager.instance
                      .primaryFocus
                      ?.unfocus();

                  overlayManager.hide();
                },
              ),
            ),
            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: position.offset,
              child: Material(
                elevation: 6,
                borderRadius:
                BorderRadius.circular(
                  8,
                ),
                child: SizedBox(
                  width:
                  position.width,
                  height:
                  position.height,
                  child: overlayBuilder(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}