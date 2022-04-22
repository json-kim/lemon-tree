import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.load() = Load;
  const factory SearchEvent.searchWithContent(String content) =
      SearchWithContent;
}
