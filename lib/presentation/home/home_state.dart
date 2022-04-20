import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    TreeCountResponse? countResponse,
  }) = _HomeState;
}
