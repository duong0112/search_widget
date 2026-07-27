class SearchConfig {
  final bool searchable;


  final bool closeOnSelect;

  final bool enableKeyboard;

  final bool enableAnimation;

  final bool autoFocusSearch;

  final Duration animationDuration;

  const SearchConfig({
    this.searchable = true,
    this.closeOnSelect = true,
    this.enableKeyboard = true,
    this.enableAnimation = true,
    this.autoFocusSearch = true,
    this.animationDuration =
    const Duration(milliseconds: 200),
  });
}