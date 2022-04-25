import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lemon_tree/domain/usecase/memory/load_memory_with_tree_use_case.dart';

import 'detail_state.dart';
import 'detail_event.dart';
import 'detail_ui_event.dart';

class DetailViewModel with ChangeNotifier {
  final LoadMemoryWithTreeUseCase _loadMemoryWithTreeUseCase;

  final _streamController = StreamController<DetailUiEvent>.broadcast();
  Stream<DetailUiEvent> get uiEventStream => _streamController.stream;

  final int treeId;

  DetailState _state = DetailState();
  DetailState get state => _state;

  DetailViewModel(this._loadMemoryWithTreeUseCase, this.treeId) {
    _initialLoad(treeId);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(DetailEvent event) {}

  Future<void> _initialLoad(int treeId) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _loadMemoryWithTreeUseCase(treeId);

    result.when(
        success: (memory) {
          _state = _state.copyWith(memory: memory);
        },
        error: (error) {});

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
