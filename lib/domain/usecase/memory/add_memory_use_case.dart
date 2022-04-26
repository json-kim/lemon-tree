import 'dart:io';

import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/image_repository.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class AddMemoryUseCase {
  final MemoryRepository _memoryRepository;
  final ImageRepository _imageRepository;

  AddMemoryUseCase(this._memoryRepository, this._imageRepository);

  Future<Result<void>> call(String content, String woodName, int themeId,
      {File? image}) async {
    return ErrorApi.handleError(() async {
      final url;
      if (image != null) {
        url = await _imageRepository.uploadImage(image);
      } else {
        url = '';
      }

      final response =
          await _memoryRepository.addMemory(content, woodName, themeId, url);

      return Result.success(null);
    }, '$runtimeType');
  }
}
