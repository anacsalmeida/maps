class Endpoint {
  static String get baseUrl =>
      'base-api';
  static String get registerUser => '/v1/createUser';
  static String get registerImage => '/v1/file';
  static String get registerLogin => '/v1/loginUser';
  static String get refreshToken => '/v1/refreshToken';
  static String get userId => '/v1/user-by-id/';
}
