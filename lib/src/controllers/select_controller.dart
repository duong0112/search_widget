import 'package:flutter/foundation.dart';

import '../models/search_item_model.dart';
import 'search_controller.dart';

class SingleSelectController<T>
    extends ChangeNotifier
    implements SearchController {
  bool _isOpen = false;

  SearchItemModel<T>? _value;

  bool get hasValue => _value != null;

  SearchItemModel<T>? get value => _value;

  @override
  bool get isOpen => _isOpen;

  @override
  void open() {
    _isOpen = true;
    notifyListeners();
  }

  @override
  void close() {
    _isOpen = false;
    notifyListeners();
  }

  @override
  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void select(SearchItemModel<T> item) {
    _value = item;
    notifyListeners();
  }

  void clear() {
    _value = null;
    notifyListeners();
  }
}