import 'package:dio/dio.dart';
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

  Future<void> requestTreeCurrentTile() async {}

  /// 로그아웃 요청 메서드
  /// @param: null
  /// @return: null
  Future<void> requestLogOut() async {
    await _tokenDio.post(ApiConstants.memberLogout);
  }
}
