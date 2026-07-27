import 'package:flutter/material.dart';

typedef DisplayText<SearchItemModel> = String Function(SearchItemModel item);

typedef ItemBuilder<SearchItemModel> =
    Widget Function(BuildContext context, SearchItemModel item, bool selected);

typedef AsyncSearch<SearchItemModel> = Future<List<SearchItemModel>> Function(String keyword);

typedef OnChanged<SearchItemModel> = void Function(SearchItemModel? value);

typedef OnMultiChanged<SearchItemModel> = void Function(List<SearchItemModel> values);
