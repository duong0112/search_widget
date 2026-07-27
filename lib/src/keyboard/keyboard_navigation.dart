class KeyboardNavigation {
  int highlightedIndex = -1;

  void reset() {
    highlightedIndex = -1;
  }

  void moveDown(int max) {
    if (max <= 0) {
      return;
    }

    highlightedIndex++;

    if (highlightedIndex >= max) {
      highlightedIndex = max - 1;
    }
  }

  void moveUp() {
    highlightedIndex--;

    if (highlightedIndex < 0) {
      highlightedIndex = 0;
    }
  }

  bool hasSelection() {
    return highlightedIndex >= 0;
  }
}