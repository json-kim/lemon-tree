import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';

import 'home_state.dart';
import 'home_event.dart';
import 'home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  final GetTreeCountUseCase _getTreeCountUseCase;

  final _streamController = StreamController<HomeUiEvent>.broadcast();
  Stream<HomeUiEvent> get uiEventStream => _streamController.stream;

  HomeState _state = HomeState();
  HomeState get state => _state;

  HomeViewModel(
    this._getTreeCountUseCase,
  ) {
    _load();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(HomeEvent event) {
    event.when(
        load: _load, getTreeCount: _getTreeCount, getMemories: _getMemories);
  }

  Future<void> _load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await _getTreeCount();
    await _getMemories();

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _getTreeCount() async {
    final result = await _getTreeCountUseCase();

    result.when(
        success: (response) {
          _state = _state.copyWith(countResponse: response);
        },
        error: (error) {});
  }

  Future<void> _getMemories() async {}
}
