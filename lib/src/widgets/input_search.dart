import 'package:flutter/material.dart';

import '../controllers/select_controller.dart';
import '../core/debounce.dart';
import '../core/search_state.dart';
import '../keyboard/keyboard_handler.dart';
import '../keyboard/keyboard_navigation.dart';
import '../models/search_item_model.dart';
import '../models/typedefs.dart';
import '../overlay/search_overlay.dart';
import '../search/search_controller.dart';
import '../search/local_search.dart';
import 'input_text_widget.dart';
import 'search_list.dart';

enum SearchType {
  localSearch, // result data on items init
  remoteSearch, // result data by function onSearch
}

class InputSearch<T> extends StatefulWidget {
  // result data by function onSearch
  const InputSearch.remote({
    super.key,
    required this.itemBuilder,
    required this.searchController,
    this.idSelected,
    this.onSelect,
    String? hintText,
    this.border,
    this.borderFocus,
    this.heightBoxResponse = 200,
    this.duration,
  }) : searchType = SearchType.remoteSearch,
       items = const [],
       hintText = hintText ?? 'Enter keyword',
       assert(searchController != null);

  // result data on items init
  const InputSearch.local({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.idSelected,
    this.onSelect,
    String? hintText,
    this.border,
    this.borderFocus,
    this.heightBoxResponse = 200,
  }) : searchType = SearchType.localSearch,
       searchController = null,
       duration = null,
       hintText = hintText ?? 'Enter keyword';

  final Duration? duration;

  final SearchType searchType;

  final List<SearchItemModel<T>> items;

  final SearchControllerCustom<T>? searchController;

  final ValueChanged<SearchItemModel<T>?>? onSelect;

  final ItemBuilder<SearchItemModel<T>> itemBuilder;

  final String hintText;

  final int? idSelected;

  final InputBorder? border;

  final InputBorder? borderFocus;

  final double heightBoxResponse;

  @override
  State<InputSearch<T>> createState() => _InputSearchState<T>();
}

class _InputSearchState<T> extends State<InputSearch<T>> {
  late SearchState<T> state;

  final navigation = KeyboardNavigation();

  final controller = SingleSelectController<T>();

  late KeyboardHandler keyboardHandler;

  int? idSelected;
  late Debounce _debounce;

  @override
  void initState() {
    _debounce = Debounce(duration: widget.duration ?? Duration(milliseconds: 300));
    super.initState();
    state = SearchState<T>();
    idSelected = widget.idSelected;
    state.focusNode.addListener(() {
      if (state.focusNode.hasFocus) {
        _openDropdown();
      }
    });
    if (widget.searchType == SearchType.localSearch) {
      // init assistant local search
      state.filteredItems = List.from(widget.items);
      final engine = LocalSearch<T>(items: widget.items, keySearch: "");
      state.textController.addListener(() => _handleSearchLocal(engine));
    } else if (widget.searchType == SearchType.remoteSearch) {
      // init assistant remote search
      state.textController.addListener(() => _handleSearchRemote());
    }

    keyboardHandler = KeyboardHandler<T>(
      navigation: navigation,
      items: () => state.filteredItems,
      scrollController: state.scrollController,
      onSelected: _selectItem,
      onClose: _closeDropdown,
      onRefresh: () {
        state.overlayManager.rebuild();
      },
    );
  }

  Future<void> _handleSearchRemote() async {
    widget.searchController!.search(
      keyword: state.textController.text,
      onResult: (result) {
        _handleDataResponse(result);
      },
    );
  }

  Future<void> _handleSearchLocal(LocalSearch<T> engine) async {
    var data = await engine.search(state.textController.text);
    _handleDataResponse(data);
  }

  void _handleDataResponse(List<SearchItemModel<T>> data) {
    state.filteredItems = data;
    if (mounted) {
      setState(() {});
      state.overlayManager.rebuild();
    }
  }

  void _openDropdown() {
    if (state.overlayManager.isShowing) {
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox;

    final overlay = SearchOverlay(
      context: context,
      layerLink: state.layerLink,
      overlayManager: state.overlayManager,
    );

    final entry = overlay.create(
      target: renderBox,
      height: widget.heightBoxResponse,
      overlayBuilder: () {
        return SearchList<T>(
          items: state.filteredItems,
          idSelected: idSelected,
          itemBuilder: widget.itemBuilder,
          onSelected: _selectItem,
          scrollController: state.scrollController,
        );
      },
    );

    state.overlayManager.show(context, entry);
  }

  void _closeDropdown() {
    state.overlayManager.hide();
  }

  void _selectItem(SearchItemModel<T> item) {
    controller.select(item);

    widget.onSelect?.call(item);

    state.textController.text = "";

    idSelected = item.id;

    _closeDropdown();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: keyboardHandler.handle,
      child: CompositedTransformTarget(
        link: state.layerLink,
        child: SearchInput(
          controller: state.textController,
          focusNode: state.focusNode,
          hintText: widget.hintText,
          border: widget.border,
          borderFocus: widget.borderFocus,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce.dispose();
    state.dispose();
    super.dispose();
  }
}
