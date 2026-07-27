import 'package:flutter/material.dart';

import '../models/search_item_model.dart';
import '../models/typedefs.dart';

class SearchItem<T> extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    required this.itemBuilder,
  });

  final SearchItemModel<T> item;

  final ItemBuilder<SearchItemModel<T>> itemBuilder;

  final bool selected;

  final VoidCallback onTap;




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: itemBuilder(context, item, selected),
    );
  }
}
