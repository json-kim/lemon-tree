class TokenResponse {
  String accessToken;
  String? refreshToken;

  TokenResponse({required this.accessToken, this.refreshToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
