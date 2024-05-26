class AuthApiResponse {
  final String token;

  AuthApiResponse({
    required this.token,
  });

  factory AuthApiResponse.fromJson(Map<String, dynamic> json) {
    return AuthApiResponse(
      token: json['access_token'],
    );
  }
}
