import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/usecase/memory/load_my_memory_use_case.dart';

import 'my_state.dart';
import 'my_event.dart';
import 'my_ui_event.dart';

class MyViewModel with ChangeNotifier {
  final LoadMyMemoryUseCase _loadMyMemoryUseCase;

  final _streamController = StreamController<MyUiEvent>.broadcast();
  Stream<MyUiEvent> get uiEventStream => _streamController.stream;

  final _memoryPagingController =
      PagingController<int, Memory>(firstPageKey: 1);
  PagingController<int, Memory> get memoryPagingController =>
      _memoryPagingController;

  MyState _state = MyState();
  MyState get state => _state;

  MyViewModel(this._loadMyMemoryUseCase) {
    _memoryPagingController.addPageRequestListener(_loadMemories);
  }

  @override
  void dispose() {
    _memoryPagingController.dispose();
    _streamController.close();
    super.dispose();
  }

  void onEvent(MyEvent event) {}

  Future<void> _loadMemories(int page) async {
    final result = await _loadMyMemoryUseCase(page);

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
}
