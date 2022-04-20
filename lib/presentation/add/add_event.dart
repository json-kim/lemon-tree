import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_event.freezed.dart';

@freezed
class AddEvent with _$AddEvent {
  const factory AddEvent.load() = Load;
  const factory AddEvent.woodSelect(String woodName) = WoodSelect;
  const factory AddEvent.themeSelect(int themeId) = ThemeSelect;
  const factory AddEvent.add(String content) = Add;
}
