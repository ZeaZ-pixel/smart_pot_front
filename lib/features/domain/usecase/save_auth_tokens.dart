import '../repositories/auth_token_repository.dart';

class SaveAuthTokens {
  final AuthTokenRepository repository;

  SaveAuthTokens(this.repository);

  Future<void> call({
    required String accessToken,
    required String refreshToken,
  }) {
    return repository.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
