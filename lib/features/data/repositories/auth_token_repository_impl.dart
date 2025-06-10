import 'package:smart_pot_front/core/services/token_storage_service.dart';
import '../../domain/repositories/auth_token_repository.dart';

class AuthTokenRepositoryImpl implements AuthTokenRepository {
  final TokenStorageService storage;

  AuthTokenRepositoryImpl(this.storage);

  @override
  Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) {
    return storage.saveTokens(accessToken, refreshToken);
  }

  @override
  Future<String?> getAccessToken() => storage.getAccessToken();

  @override
  Future<String?> getRefreshToken() => storage.getRefreshToken();

  @override
  Future<void> clearTokens() => storage.clearTokens();
}
