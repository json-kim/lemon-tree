import 'package:lemon_tree/data/data_source/remote/token_api.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class TreeRepositoryImpl implements TreeRepository {
  final TokenApi _tokenApi;

  TreeRepositoryImpl(this._tokenApi);

  @override
  Future<TreeCountResponse> getTreeCount() async {
    return await _tokenApi.requestTreeCount();
  }

  @override
  Future<List<Tree>> getTreeList(int zoom, int tileX, int tileY) async {
    return await _tokenApi.requestTreeCurrentTile(tileX, tileY);
  }
}
