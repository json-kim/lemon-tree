import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.load() = Load;
  const factory HomeEvent.getTreeCount() = GetTreeCount;
  const factory HomeEvent.getMemories() = GetMemories;
}
