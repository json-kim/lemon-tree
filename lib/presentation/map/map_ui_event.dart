import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_ui_event.freezed.dart';

@freezed
class MapUiEvent with _$MapUiEvent {
  const factory MapUiEvent.snackBar(String message) = SnackBar;
}
