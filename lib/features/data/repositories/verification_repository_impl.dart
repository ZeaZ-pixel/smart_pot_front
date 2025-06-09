import 'package:dio/dio.dart';
import 'package:smart_pot_front/config/constants/api_constants.dart';
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
  Future<void> verifyCode({required String email, required String code}) async {
    try {
      await dio.post(ApiConstants.verifyEmailCode, data: {
        'email': email,
        'code': code,
      });
    } catch (e) {
      throw Exception('Неверный код');
    }
  }
}
