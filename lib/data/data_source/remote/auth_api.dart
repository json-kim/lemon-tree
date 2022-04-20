import 'package:dio/dio.dart';
import 'package:lemon_tree/domain/model/auth/token_response.dart';
import 'package:lemon_tree/service/server_api/api_constants.dart';
import 'package:lemon_tree/service/server_api/api_factory.dart';
import 'package:logger/logger.dart';

class AuthApi {
  final Dio _authDio;

  static final AuthApi instance = AuthApi();

  AuthApi({Dio? authDio}) : _authDio = authDio ?? ApiFactory.authApi;

  /// 로그인 요청 메서드
  /// @param: email, password
  /// @return: TokenResponse(class)
  Future<TokenResponse> requestLogIn(String email, String password) async {
    final body = {
      ApiConstants.email: email,
      ApiConstants.pw: password,
    };

    final response = await _authDio.post(ApiConstants.memberLogin, data: body);

    final token = TokenResponse.fromJson(response.data['response']);

    return token;
  }

  /// 회원가입 요청 메서드
  /// @param: email, password, name
  /// @return: null
  Future<void> requestSignUp(String email, String password, String name) async {
    final body = {
      ApiConstants.email: email,
      ApiConstants.pw: password,
      ApiConstants.name: name,
    };

    await _authDio.post(ApiConstants.memberInsert, data: body);
  }

  /// 액세스 토큰 재발급 요청 메서드
  /// @param: refreshToken(String)
  /// @return: TokenResponse(class)
  Future<TokenResponse> refreshAccessToken(String refreshToken) async {
    final body = {
      ApiConstants.refreshToken: refreshToken,
    };

    final response =
        await _authDio.post(ApiConstants.memberRefresh, data: body);

    Logger().i(response);

    final tokenResponse = TokenResponse.fromJson(response.data['response']);

    return tokenResponse;
  }
}
