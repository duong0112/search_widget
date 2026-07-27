import '../models/search_item_model.dart';
import 'search_engine.dart';

class LocalSearch<T> implements SearchEngine {
  LocalSearch({required this.items, required this.keySearch});

  final List<SearchItemModel<T>> items;

  final String keySearch;

  @override
  Future<List<SearchItemModel<T>>> search(String keyword) async {
    if (keyword.isEmpty) {
      return items;
    }


    return items.where((e) {
      return e.keySearch.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }
}
