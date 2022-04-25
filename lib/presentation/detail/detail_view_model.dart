import 'dart:async';

import 'package:flutter/material.dart';

import 'detail_state.dart';
import 'detail_event.dart';
import 'detail_ui_event.dart';

class DetailViewModel with ChangeNotifier {
  final _streamController = StreamController<DetailUiEvent>.broadcast();
  Stream<DetailUiEvent> get uiEventStream => _streamController.stream;

  DetailState _state = DetailState();
  DetailState get state => _state;

  DetailViewModel();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(DetailEvent event) {}
}
