class Endpoints {
  static const String apiBaseUrl = 'https://walak-api.herokuapp.com/api';

  //response codes
  static const int codeSuccess = 200;
  static const int codeCreated = 201;
  static const int codeBadRequest = 400;
  static const int codeUnauthorized = 401;
  static const int codeForbidden = 403;
  static const int codeNotFound = 404;
  static const int codeServerError = 500;

  //user
  static const String signIn = '/user/login';
  static const String refreshToken = '/user/refresh-token';
  static const String getUserProfile = '/user';
  static const String changePassword = '/user/change-password';

  //nomenclator
  static const String getAllPaymentMethods =
      '/nomenclator/payments_methods/all';

  //source
  static const String getSource = '/source';
  static const String depositRequest = '/source/deposit/request';
}
