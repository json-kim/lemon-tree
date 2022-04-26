import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/usecase/memory/load_memory_use_case.dart';

import 'search_state.dart';
import 'search_event.dart';
import 'search_ui_event.dart';

class SearchViewModel with ChangeNotifier {
  final LoadMemoryUseCase _loadMemoryUseCase;

  final _streamController = StreamController<SearchUiEvent>.broadcast();
  Stream<SearchUiEvent> get uiEventStream => _streamController.stream;

  SearchState _state = SearchState();
  SearchState get state => _state;

  final _memoryPagingController =
      PagingController<int, Memory>(firstPageKey: 1);
  PagingController<int, Memory> get memoryPagingController =>
      _memoryPagingController;

  SearchViewModel(
    this._loadMemoryUseCase,
  ) {
    _memoryPagingController.addPageRequestListener(_loadMemories);
    _load();
  }

  @override
  void dispose() {
    _memoryPagingController.dispose();
    _streamController.close();
    super.dispose();
  }

  void onEvent(SearchEvent event) {
    event.when(
        woodSelect: _woodSelect,
        themeSelect: _themeSelect,
        load: _load,
        searchWithContent: _searchWithContnet);
  }

  void _woodSelect(String? woodName) {
    _state = _state.copyWith(selectedWood: woodName);

    notifyListeners();
    _memoryPagingController.refresh();
  }

  void _themeSelect(int? themeId) {
    _state = _state.copyWith(selectedTheme: themeId);

    notifyListeners();
    _memoryPagingController.refresh();
  }

  Future<void> _loadMemories(int page) async {
    final result = await _loadMemoryUseCase(page,
        woodName: _state.selectedWood, themeId: _state.selectedTheme);

    result.when(
        success: (pageResult) {
          final isLastPage = pageResult.isLastPage;
          final newItems = pageResult.items;

          if (isLastPage) {
            _memoryPagingController.appendLastPage(newItems);
          } else {
            _memoryPagingController.appendPage(newItems, page + 1);
          }
        },
        error: (error) {});
  }

  Future<void> _load() async {}

  Future<void> _searchWithContnet(String content) async {}
}
