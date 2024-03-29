import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';

part 'add_state.freezed.dart';

@freezed
class AddState with _$AddState {
  const factory AddState({
    @Default(false) bool isTreeSelected,
    @Default(false) bool isLoading,
    File? selectedImage,
    Tree? tree,
    int? selectedTheme,
    String? selectedWood,
    TreeCountResponse? countResponse,
  }) = _AddState;
}
