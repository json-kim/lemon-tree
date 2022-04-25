import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_tile_use_case.dart';

import 'map_state.dart';
import 'map_event.dart';
import 'map_ui_event.dart';

class MapViewModel with ChangeNotifier {
  final GetTreeTileUseCase _getTreeTileUseCase;

  final _streamController = StreamController<MapUiEvent>.broadcast();
  Stream<MapUiEvent> get uiEventStream => _streamController.stream;

  MapState _state = MapState();
  MapState get state => _state;

  MapViewModel(this._getTreeTileUseCase);

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(MapEvent event) {
    event.when(loadMarkers: _loadMarkers);
  }

  Future<void> _loadMarkers(double lat, double lng) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _getTreeTileUseCase(lat, lng);

    result.when(
        success: (list) {
          _state = _state.copyWith(trees: list);
        },
        error: (error) {});

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
