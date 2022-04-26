import 'dart:io';

import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/image_repository.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class AddMemoryWithTreeUseCase {
  final MemoryRepository _memoryRepository;
  final ImageRepository _imageRepository;

  AddMemoryWithTreeUseCase(this._memoryRepository, this._imageRepository);

  Future<Result<void>> call(String content, int treeId, int themeId,
      {File? image}) async {
    return ErrorApi.handleError(() async {
      final url;
      if (image != null) {
        url = await _imageRepository.uploadImage(image);
      } else {
        url = '';
      }

      await _memoryRepository.addMemoryWithTree(content, treeId, themeId, url);

      return Result.success(null);
    }, '$runtimeType');
  }
}
