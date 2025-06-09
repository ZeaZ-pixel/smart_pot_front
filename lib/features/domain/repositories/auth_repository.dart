abstract class AuthRepository {
  Future<void> register({
    required String username,
    required String email,
    required String password,
  });
}
