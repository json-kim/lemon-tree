import 'package:lemon_tree/domain/model/tree_count_response.dart';

import '../model/tree.dart';

abstract class TreeRepository {
  Future<List<Tree>> getTreeList(int zoom, int tileX, int tileY);

  Future<TreeCountResponse> getTreeCount();
}
