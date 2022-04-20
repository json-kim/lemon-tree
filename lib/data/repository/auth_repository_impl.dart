import 'package:lemon_tree/data/data_source/local/token_local_data_source.dart';
import 'package:lemon_tree/data/data_source/remote/auth_api.dart';
import 'package:lemon_tree/data/data_source/remote/token_api.dart';
import 'package:lemon_tree/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final TokenApi _tokenApi;
  final TokenLocalDataSource _tokenLocalDataSource;

  AuthRepositoryImpl(this._authApi, this._tokenApi, this._tokenLocalDataSource);

  @override
  Future<void> logOut() async {
    // 로그아웃 요청
    await _tokenApi.requestLogOut();

    // 로컬에서 토큰 제거
    await _tokenLocalDataSource.deleteAccessToken();
    await _tokenLocalDataSource.deleteRefreshToken();
  }

  @override
  Future<void> loginWithEmail(String email, String password) async {
    // 로그인 요청, 토큰 반환
    final tokenResponse = await _authApi.requestLogIn(email, password);

    // 로컬에 토큰 저장
    await _tokenLocalDataSource.saveAccessToken(tokenResponse.accessToken);
    await _tokenLocalDataSource.saveRefreshToken(tokenResponse.refreshToken);
  }

  @override
  Future<void> signUpWithEmail(
      String email, String password, String name) async {
    // 회원가입 요청
    await _authApi.requestSignUp(email, password, name);
  }
}
