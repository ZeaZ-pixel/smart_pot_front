import 'package:smart_pot_front/features/domain/entities/token_pair.dart';

abstract class VerificationRepository {
  Future<void> sendCode(String email);
  Future<TokensPair> verifyCode({required String email, required String code});
}
