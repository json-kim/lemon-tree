import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_event.freezed.dart';

@freezed
class AddEvent with _$AddEvent {
  const factory AddEvent.load() = Load;
  const factory AddEvent.woodSelect(String woodName) = WoodSelect;
  const factory AddEvent.themeSelect(int themeId) = ThemeSelect;
  const factory AddEvent.imageSelect(File image) = ImageSelect;
  const factory AddEvent.imageDelete() = ImageDelete;
  const factory AddEvent.add(String content) = Add;
}
