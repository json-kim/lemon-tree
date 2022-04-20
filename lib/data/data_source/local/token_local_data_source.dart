import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenLocalDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  TokenLocalDataSource._();

  static final TokenLocalDataSource _instance = TokenLocalDataSource._();
  static TokenLocalDataSource get instance => _instance;

  /// 액세스 토큰 저장(로컬에)
  Future<void> saveAccessToken(String? accessToken) async {
    if (accessToken == null) return;

    await _secureStorage.write(key: 'access_token', value: accessToken);
  }

  /// 리프레시 토큰 저장(로컬에)
  Future<void> saveRefreshToken(String? refreshToken) async {
    if (refreshToken == null) return;

    await _secureStorage.write(key: 'refresh_token', value: refreshToken);
  }

  /// 액세스 토큰 불러오기
  Future<String?> loadAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  /// 리프레시 토큰 불러오기
  Future<String?> loadRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  /// 액세스 토큰 삭제하기
  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: 'access_token');
  }

  /// 리프레시 토큰 삭제하기
  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: 'refresh_token');
  }
}
