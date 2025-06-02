class ApiConfig {
  static const String baseUrl =
      'https://creative-endlessly-bullfrog.ngrok-free.app/api';
  static const String loginEndpoint = '$baseUrl/Auth/login';
  static const String registerEndpoint = '$baseUrl/Auth/register';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}
