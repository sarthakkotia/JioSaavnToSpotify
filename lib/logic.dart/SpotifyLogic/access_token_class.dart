class AccessTokenClass {
  final String access_token;
  final String token_type;
  final String scope;
  final int expires_in;
  final String refresh_token;
  AccessTokenClass(
      {required this.access_token,
      required this.token_type,
      required this.expires_in,
      required this.refresh_token,
      required this.scope});
}
