import 'dart:math';

import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';

class GetTreeTileUseCase {
  final TreeRepository _treeRepository;

  GetTreeTileUseCase(this._treeRepository);

  Future<Result<List<Tree>>> call(double lat, double lng) async {
    return ErrorApi.handleError(() async {
      // 확대/축소 (zoom)
      const zoom = 16;

      // 타일의 수 = 2**zoom * 2**zoom
      final zoomPow = (pow(2, zoom)).round();
      final tiles = zoomPow * zoomPow;

      // 16 수준에서의 위도 경도의 타일 좌표 구하는 공식
      final sinLat = sin(lat * pi / 180);

      final pixelX = ((lng + 180) / 360) * tiles * zoomPow;
      final tileX = (pixelX / tiles).floor();

      final pixelY =
          (0.5 - log((1 + sinLat) / (1 - sinLat)) / (4 * pi)) * tiles * zoomPow;
      final tileY = (pixelY / tiles).floor();

      final treeList = await _treeRepository.getTreeList(16, tileX, tileY);

      return Result.success(treeList);
    }, '$runtimeType');
  }
}
