class SearchItemModel<T>{
  final int id;
  final String keySearch;
  final T? data;

  const SearchItemModel({
    required this.id,
    required this.keySearch,
    this.data,
  });

  @override
  String toString() {
    return 'SearchItemModel{value: $id, data: $keySearch}';
  }

  @override
  bool operator == (Object other) {
    if (other is! SearchItemModel<T>) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
