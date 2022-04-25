import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_ui_event.freezed.dart';

@freezed
class MyUiEvent with _$MyUiEvent {
  const factory MyUiEvent.snackBar(String message) = SnackBar;
}
