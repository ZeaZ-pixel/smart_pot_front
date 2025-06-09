import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'localhost:3000';

  static final String register = '$baseUrl/auth/register';
  static final String login = '$baseUrl/auth/login';
  static final String userProfile = '$baseUrl/user/profile';
  static final String sendEmailCode = '$baseUrl/auth/email-code';
  static final String verifyEmailCode = '$baseUrl/auth/email-code/verify';
}
