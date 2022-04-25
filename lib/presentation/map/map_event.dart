import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_event.freezed.dart';

@freezed
class MapEvent with _$MapEvent {
  const factory MapEvent.loadMarkers(double lat, double lng) = LoadMarkers;
}
