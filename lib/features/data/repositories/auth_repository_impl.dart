import 'package:smart_pot_front/config/constants/api_constants.dart';
import 'package:smart_pot_front/features/domain/entities/token_pair.dart';

import '../../domain/repositories/auth_repository.dart';

import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  AuthRepositoryImpl(this.dio);

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Ошибка регистрации');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ??
          e.response?.statusMessage ??
          'Ошибка регистрации';
      throw Exception(message);
    } catch (_) {
      throw Exception('Непредвиденная ошибка');
    }
  }

  @override
  Future<TokensPair> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Ошибка регистрации');
      }
      final accessToken = response.data['accessToken'];
      final refreshToken = response.data['refreshToken'];
      if (accessToken != null && refreshToken != null) {
        return TokensPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else {
        throw Exception('Сервер не вернул токены');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ??
          e.response?.statusMessage ??
          'Ошибка регистрации';
      throw Exception(message);
    } catch (_) {
      throw Exception('Непредвиденная ошибка');
    }
  }
}
