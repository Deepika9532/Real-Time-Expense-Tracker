class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';
  static const String apiBaseUrl = '$baseUrl$apiVersion';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String deleteAccount = '/user/delete';

  // Common Endpoints
  static const String getList = '/items';
  static const String getById = '/items/{id}';
  static const String create = '/items/create';
  static const String update = '/items/update/{id}';
  static const String delete = '/items/delete/{id}';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAccept = 'Accept';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';

  // Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusInternalServerError = 500;
}
