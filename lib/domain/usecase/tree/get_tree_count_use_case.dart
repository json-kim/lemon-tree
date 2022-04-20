import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class GetTreeCountUseCase {
  final TreeRepository _treeRepository;

  GetTreeCountUseCase(this._treeRepository);

  Future<Result<TreeCountResponse>> call() async {
    final treeCounts = await _treeRepository.getTreeCount();

    return Result.success(treeCounts);
  }
}
