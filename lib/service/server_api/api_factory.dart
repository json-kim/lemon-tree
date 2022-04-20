import 'package:dio/dio.dart';
import 'package:lemon_tree/data/data_source/local/token_local_data_source.dart';
import 'package:lemon_tree/data/data_source/remote/auth_api.dart';
import 'package:lemon_tree/service/server_api/api_constants.dart';
import 'package:lemon_tree/service/server_api/api_token_interceptor.dart';

class ApiFactory {
  static final authApi = _authApiInstance();
  static final tokenApi = _tokenApiInstance();

  static Dio _authApiInstance() {
    var dio = Dio();
    dio.options.baseUrl = '${ApiConstants.scheme}://${ApiConstants.base}';
    dio.options.contentType = ApiConstants.contentType;
    dio.interceptors.addAll([
      LogInterceptor(),
    ]);

    return dio;
  }

  static Dio _tokenApiInstance() {
    var dio = Dio();
    dio.options.baseUrl = '${ApiConstants.scheme}://${ApiConstants.base}';
    dio.options.contentType = ApiConstants.contentType;
    dio.interceptors.addAll([
      ApiTokenInterceptor(dio, TokenLocalDataSource.instance, AuthApi.instance),
      LogInterceptor(),
    ]);

    return dio;
  }
}
