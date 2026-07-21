import 'package:flutter/foundation.dart';

import '../models.dart';

class ObservableList<T> extends ChangeNotifier {
  final List<T> _items = <T>[];

  List<T> get value => List.unmodifiable(_items);
  int get length => _items.length;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  T operator [](int index) => _items[index];

  void assignAll(Iterable<T> items) {
    _items
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void addAll(Iterable<T> items) {
    _items.addAll(items);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class PaginationState<T> {
  PaginationState({this.perPage = 10});

  final int perPage;
  final ObservableList<T> items = ObservableList<T>();
  final ValueNotifier<bool> isInitialLoading = ValueNotifier(false);
  final ValueNotifier<bool> isLoadingMore = ValueNotifier(false);
  final ValueNotifier<bool> isRefreshing = ValueNotifier(false);

  int currentPage = 1;
  int? total;
  bool hasMore = true;

  bool get isBusy =>
      isInitialLoading.value || isLoadingMore.value || isRefreshing.value;

  void reset() {
    currentPage = 1;
    total = null;
    hasMore = true;
    items.clear();
  }

  void setPage({required List<T> data, required int page, MetaList? meta}) {
    if (page == 1) {
      items.assignAll(data);
    } else {
      items.addAll(data);
    }

    currentPage = meta?.currentPage ?? page;
    total = meta?.total ?? total;
    hasMore = _resolveHasMore(data, meta);
  }

  bool _resolveHasMore(List<T> data, MetaList? meta) {
    if (meta?.to != null && meta?.total != null) {
      return meta!.to! < meta.total!;
    }
    if (meta?.currentPage != null &&
        meta?.perPage != null &&
        meta?.total != null) {
      return meta!.currentPage! * meta.perPage! < meta.total!;
    }
    return data.length >= perPage;
  }
}
