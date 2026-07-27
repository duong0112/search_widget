import '../core/debounce.dart';
import '../models/search_item_model.dart';

class SearchControllerCustom<T> {
  SearchControllerCustom({
    required this.onSearch,
    Duration debounceDuration = const Duration(milliseconds: 300),
  }) : _debounce = Debounce(duration: debounceDuration);

  final Debounce _debounce;
  final Future<List<SearchItemModel<T>>> Function(String keyword) onSearch;

  int _requestId = 0;

  Future<void> search({
    required String keyword,
    required void Function(List<SearchItemModel<T>> result) onResult,
  }) async {
    final requestId = ++_requestId;
    _debounce.run(() async {
      final result = await onSearch(keyword);
      if (requestId != _requestId) {
        return;
      }
      onResult(result);
    });
  }
}
