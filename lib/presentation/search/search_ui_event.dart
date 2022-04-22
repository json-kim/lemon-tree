import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ui_event.freezed.dart';

@freezed
class SearchUiEvent with _$SearchUiEvent {
  const factory SearchUiEvent.snackBar(String message) = SnackBar;
}
