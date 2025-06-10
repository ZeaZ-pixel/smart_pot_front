import 'package:dio/dio.dart';
import 'package:smart_pot_front/config/constants/api_constants.dart';
import 'package:smart_pot_front/features/domain/entities/token_pair.dart';
import '../../domain/repositories/verification_repository.dart';

class VerificationRepositoryImpl implements VerificationRepository {
  final Dio dio;
  VerificationRepositoryImpl(this.dio);

  @override
  Future<void> sendCode(String email) async {
    try {
      var data =
          await dio.post(ApiConstants.sendEmailCode, data: {'email': email});
    } catch (e) {
      throw Exception('Ошибка отправки кода');
    }
  }

  @override
  Future<TokensPair> verifyCode(
      {required String email, required String code}) async {
    try {
      final response = await dio.post(ApiConstants.verifyEmailCode, data: {
        'email': email,
        'code': code,
      });

      final accessToken = response.data['access_token'];
      final refreshToken = response.data['refresh_token'];

      if (accessToken != null && refreshToken != null) {
        return TokensPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else {
        throw Exception('Сервер не вернул токены');
      }
    } catch (e) {
      throw Exception('Неверный код');
    }
  }
}
