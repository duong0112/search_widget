import 'package:flutter/material.dart';

import '../models/search_item_model.dart';
import '../models/typedefs.dart';
import 'search_item.dart';

class SearchList<T> extends StatelessWidget {
  const SearchList({
    super.key,
    required this.items,
    required this.idSelected,
    required this.onSelected,
    required this.scrollController,
    required this.itemBuilder,
  });

  final List<SearchItemModel<T>> items;

  final int? idSelected;

  final ValueChanged<SearchItemModel<T>> onSelected;

  final ScrollController scrollController;

  final ItemBuilder<SearchItemModel<T>> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No items found'),
      );
    }
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final selected = items[index].id == idSelected;
        return SearchItem<T>(
          item: item,
          itemBuilder: itemBuilder,
          selected: selected,
          onTap: () {
            onSelected(item);
          },
        );
      },
    );
  }
}
