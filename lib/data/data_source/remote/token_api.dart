import 'package:dio/dio.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/service/server_api/api_constants.dart';
import 'package:lemon_tree/service/server_api/api_factory.dart';

class TokenApi {
  final Dio _tokenDio;

  TokenApi({Dio? tokenDio}) : _tokenDio = tokenDio ?? ApiFactory.tokenApi;

  static final instance = TokenApi();

  Future<TreeCountResponse> requestTreeCount() async {
    final response = await _tokenDio.get(ApiConstants.treeCount);

    final countResponse = TreeCountResponse.fromJson(response.data);

    return countResponse;
  }

  /// 타일별 나무 리스트 요청 메서드
  /// @param: zoom(int), tileX(int), tileY(int)
  /// @return: List<Tree>
  Future<List<Tree>> requestTreeCurrentTile(int tileX, int tileY) async {
    final params = {
      ApiConstants.tileX: tileX,
      ApiConstants.tileY: tileY,
    };

    final response =
        await _tokenDio.get(ApiConstants.treeTile, queryParameters: params);
    final List jsonList = response.data;

    return jsonList.map((json) => Tree.fromJson(json)).toList();
  }

  /// 로그아웃 요청 메서드
  /// @param: null
  /// @return: null
  Future<void> requestLogOut() async {
    await _tokenDio.post(ApiConstants.memberLogout);
  }

  /// 메모리 추가 요청 메서드
  /// @param: content(String), woodName(String), themeId(int)
  /// @return: null
  Future<void> requestAddMemory(
      String content, String woodName, int themeId) async {
    final body = {
      ApiConstants.content: content,
      ApiConstants.woodName: woodName,
      ApiConstants.themeId: themeId,
      ApiConstants.private: 0,
    };

    final response =
        await _tokenDio.post(ApiConstants.memoryInsert, data: body);
  }

  /// 메모리 추가(TreeId) 요청 메서드
  /// @param: content(String), treeId(int), themeId(int)
  /// @return: null
  Future<void> requestAddMemoryWithTree(
      String content, int treeId, int themeId) async {
    final body = {
      ApiConstants.content: content,
      ApiConstants.treeId: treeId,
      ApiConstants.themeId: themeId,
      ApiConstants.private: 0,
    };

    final response =
        await _tokenDio.post(ApiConstants.memoryInsertWithTree, data: body);
  }
}
