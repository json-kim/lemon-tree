import 'dart:async';

import 'package:flutter/material.dart';

import 'search_state.dart';
import 'search_event.dart';
import 'search_ui_event.dart';

class SearchViewModel with ChangeNotifier {
  final _streamController = StreamController<SearchUiEvent>.broadcast();
  Stream<SearchUiEvent> get uiEventStream => _streamController.stream;

  SearchState _state = SearchState();
  SearchState get state => _state;

  SearchViewModel() {
    _load();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(SearchEvent event) {
    event.when(load: _load, searchWithContent: _searchWithContnet);
  }

  Future<void> _load() async {}

  Future<void> _searchWithContnet(String content) async {}
}
