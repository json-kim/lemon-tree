import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_state.freezed.dart';

@freezed
class MyState with _$MyState {
  const factory MyState({
    @Default(false) bool isLoading,
  }) = _MyState;
}
