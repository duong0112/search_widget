import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/search_item_model.dart';
import 'keyboard_navigation.dart';
import 'keyboard_scroll.dart';

class KeyboardHandler<T> {
  KeyboardHandler({
    required this.navigation,
    required this.items,
    required this.scrollController,
    required this.onSelected,
    required this.onClose,
    required this.onRefresh,
  });

  final KeyboardNavigation navigation;

  final List<SearchItemModel<T>> Function() items;

  final ScrollController scrollController;

  final ValueChanged<SearchItemModel<T>> onSelected;

  final VoidCallback onClose;

  final VoidCallback onRefresh;

  KeyEventResult handle(
      FocusNode node,
      KeyEvent event,
      ) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final currentItems = items();

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        navigation.moveDown(
          currentItems.length,
        );

        KeyboardScroll.scrollTo(
          scrollController,
          navigation.highlightedIndex,
          48,
        );

        onRefresh();

        return KeyEventResult.handled;

      case LogicalKeyboardKey.arrowUp:
        navigation.moveUp();

        KeyboardScroll.scrollTo(
          scrollController,
          navigation.highlightedIndex,
          48,
        );

        onRefresh();

        return KeyEventResult.handled;

      case LogicalKeyboardKey.enter:
        if (navigation.hasSelection() &&
            navigation.highlightedIndex <
                currentItems.length) {
          onSelected(
            currentItems[
            navigation.highlightedIndex],
          );
        }

        return KeyEventResult.handled;

      case LogicalKeyboardKey.escape:
        onClose();

        return KeyEventResult.handled;

      default:
        return KeyEventResult.ignored;
    }
  }
}