import 'package:flutter/material.dart';
import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/page/page.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/repository/memory_repository.dart';

class LoadMemoryUseCase {
  final MemoryRepository _memoryRepository;

  LoadMemoryUseCase(this._memoryRepository);

  Future<Result<Pagination<Memory>>> call(int page,
      {String? woodName, int? themeId}) async {
    return ErrorApi.handleError(() async {
      final memories = await _memoryRepository.loadMemories(page,
          woodName: woodName, themeId: themeId);

      return Result.success(memories);
    }, '$runtimeType');
  }
}
