abstract class VerificationRepository {
  Future<void> sendCode(String email);
  Future<void> verifyCode({required String email, required String code});
}
