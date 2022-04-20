import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_ui_event.freezed.dart';

@freezed
class AddUiEvent with _$AddUiEvent {
  const factory AddUiEvent.snackBar(String message) = SnackBar;
  const factory AddUiEvent.addSuccess() = AddSuccess;
}
