import '../models/search_item_model.dart';

abstract class SearchEngine<T> {
  Future<List<SearchItemModel<T>>> search(String keyword);
}
