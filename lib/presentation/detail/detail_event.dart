import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_event.freezed.dart';

@freezed
class DetailEvent with _$DetailEvent {
  const factory DetailEvent.load() = Load;
}
