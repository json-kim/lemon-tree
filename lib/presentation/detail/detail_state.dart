import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lemon_tree/domain/model/memory.dart';

part 'detail_state.freezed.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState({
    @Default(false) bool isLoading,
    Memory? memory,
  }) = _DetailState;
}
