class ApiException implements Exception {
  String? message;
  String? code;

  ApiException({this.message, this.code});
}

class ApiTokenException extends ApiException {}

enum ApiErrorCause {
  /// 잘못된 이메일
  invalidEmail,

  /// 잘못된 비밀번호
  invalidPassword,

  /// 잘못된 유저 이름
  invalidName,

  /// 이미 존재하는 이메일
  existEmail,

  /// 이미 존재하는 이름
  existName,

  /// 기타 에러
  unknow,
}
