import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lemon_tree/domain/model/tree.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(false) bool isLoading,
    @Default([]) List<Tree> trees,
  }) = _MapState;
}
