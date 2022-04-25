import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_ui_event.freezed.dart';

@freezed
class DetailUiEvent with _$DetailUiEvent {
  const factory DetailUiEvent.snackBar(String message) = SnackBar;
}
