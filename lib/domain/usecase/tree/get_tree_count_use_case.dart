import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class GetTreeCountUseCase {
  final TreeRepository _treeRepository;

  GetTreeCountUseCase(this._treeRepository);

  Future<Result<TreeCountResponse>> call() async {
    return ErrorApi.handleError(() async {
      final treeCounts = await _treeRepository.getTreeCount();

      final woodCounts = treeCounts.woodCounts;

      return Result.success(treeCounts.copyWith(
          woodCounts:
              woodCounts.where((count) => count.values.first > 0).toList()));
    }, '$runtimeType');
  }
}
