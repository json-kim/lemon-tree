import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_use_case.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_with_tree_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';

import 'add_state.dart';
import 'add_event.dart';
import 'add_ui_event.dart';

class AddViewModel with ChangeNotifier {
  final GetTreeCountUseCase _getTreeCountUseCase;
  final AddMemoryUseCase _addMemoryUseCase;
  final AddMemoryWithTreeUseCase _addMemoryWithTreeUseCase;

  final _streamController = StreamController<AddUiEvent>.broadcast();
  Stream<AddUiEvent> get uiEventStream => _streamController.stream;

  AddState _state;
  AddState get state => _state;

  AddViewModel(
    this._getTreeCountUseCase,
    this._addMemoryUseCase,
    this._addMemoryWithTreeUseCase, {
    Tree? tree,
  }) : _state = AddState(
          isTreeSelected: tree != null,
          selectedWood: tree?.woodName,
          tree: tree,
        ) {
    _load();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(AddEvent event) {
    event.when(
        load: _load,
        imageSelect: _imageSelect,
        imageDelete: _imageDelete,
        woodSelect: _woodSelect,
        themeSelect: _themeSelect,
        add: _add);
  }

  void _imageSelect(File image) {
    _state = _state.copyWith(selectedImage: image);
    notifyListeners();
  }

  void _imageDelete() {
    _state = _state.copyWith(selectedImage: null);
    notifyListeners();
  }

  void _woodSelect(String woodName) {
    _state = _state.copyWith(selectedWood: woodName);
    notifyListeners();
  }

  void _themeSelect(int themeId) {
    _state = _state.copyWith(selectedTheme: themeId);
    notifyListeners();
  }

  Future<void> _load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _getTreeCountUseCase();

    result.when(
        success: (response) {
          _state = _state.copyWith(countResponse: response);
        },
        error: (error) {});

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _add(String content) async {
    if (_state.isTreeSelected) {
      _addWithTreeId(content);
    } else {
      _addWithWoodName(content);
    }
  }

  Future<void> _addWithWoodName(String content) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final selectedWood = _state.selectedWood;
    final selectedTheme = _state.selectedTheme;
    if (selectedWood == null || selectedTheme == null) {
      _streamController.add(const AddUiEvent.snackBar('값을 다시 입력해주세요'));
    } else {
      final result = await _addMemoryUseCase(
          content, selectedWood, selectedTheme,
          image: _state.selectedImage);

      result.when(
        success: (_) {
          _streamController.add(const AddUiEvent.addSuccess());
        },
        error: (error) {},
      );
    }

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _addWithTreeId(String content) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final selectedTree = _state.tree;
    final selectedTheme = _state.selectedTheme;
    if (selectedTree == null || selectedTheme == null) {
      _streamController.add(const AddUiEvent.snackBar('값을 다시 입력해주세요'));
    } else {
      final result = await _addMemoryWithTreeUseCase(
          content, selectedTree.id, selectedTheme,
          image: _state.selectedImage);

      result.when(
        success: (_) {
          _streamController.add(const AddUiEvent.addSuccess());
        },
        error: (error) {},
      );
    }

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
