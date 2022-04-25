import 'package:dio/dio.dart';
import 'package:lemon_tree/core/page/page.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/model/tree.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/presentation/constants/data.dart';
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

  /// 메모리 리스트 요청 메서드
  /// @param: page(int)
  /// @return: Pagination<Memory>
  Future<Pagination<Memory>> requestMemories(int page) async {
    final params = {
      ApiConstants.page: page,
    };

    final response =
        await _tokenDio.get(ApiConstants.memeoryList, queryParameters: params);

    final jsonData = response.data;
    final List jsonMeories = jsonData['result'];
    final memories = jsonMeories.map((json) => Memory.fromJson(json)).toList();

    final pagination = Pagination(
        currentPage: jsonData['current_page'] as int,
        lastPage: jsonData['total_page'] as int,
        items: memories);

    return pagination;
  }

  /// 메모리 리스트 요청 메서드(나무, 테마)
  /// @param: page(int), woodName(String), themeId(int)
  /// @return: Pagination<Memory>
  Future<Pagination<Memory>> requestMemoriesWoodTheme(
      String woodName, int themeId, int page) async {
    final params = {
      ApiConstants.page: page,
      ApiConstants.woodName: woodName,
      ApiConstants.theme: themeMap.keys.toList()[themeId - 1],
    };

    final response = await _tokenDio.get(ApiConstants.memoryWoodThemeList,
        queryParameters: params);

    final jsonData = response.data;
    final List jsonMeories = jsonData['result'];
    final memories = jsonMeories.map((json) => Memory.fromJson(json)).toList();

    final pagination = Pagination(
        currentPage: jsonData['current_page'] as int,
        lastPage: jsonData['total_page'] as int,
        items: memories);

    return pagination;
  }

  /// 메모리 리스트 요청 메서드(나무)
  /// @param: page(int), woodName(String)
  /// @return: Pagination<Memory>
  Future<Pagination<Memory>> requestMemoriesWood(
      String woodName, int page) async {
    final params = {ApiConstants.woodName: woodName, ApiConstants.page: page};

    final response = await _tokenDio.get(ApiConstants.memoryWoodList,
        queryParameters: params);

    final jsonData = response.data;
    final List jsonMeories = jsonData['result'];
    final memories = jsonMeories.map((json) => Memory.fromJson(json)).toList();

    final pagination = Pagination(
        currentPage: jsonData['current_page'] as int,
        lastPage: jsonData['total_page'] as int,
        items: memories);

    return pagination;
  }

  /// 메모리 리스트 요청 메서드(테마)
  /// @param: page(int), themeId(int)
  /// @return: Pagination<Memory>
  Future<Pagination<Memory>> requestMemoriesTheme(int themeId, int page) async {
    final params = {
      ApiConstants.theme: themeMap.keys.toList()[themeId - 1],
      ApiConstants.page: page,
    };

    final response = await _tokenDio.get(ApiConstants.memoryThemeList,
        queryParameters: params);

    final jsonData = response.data;
    final List jsonMeories = jsonData['result'];
    final memories = jsonMeories.map((json) => Memory.fromJson(json)).toList();

    final pagination = Pagination(
        currentPage: jsonData['current_page'] as int,
        lastPage: jsonData['total_page'] as int,
        items: memories);

    return pagination;
  }
}
