import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_event.freezed.dart';

@freezed
class MyEvent with _$MyEvent {
  const factory MyEvent.load() = Load;
}
