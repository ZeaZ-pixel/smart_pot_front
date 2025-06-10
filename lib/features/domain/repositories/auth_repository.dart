import 'package:smart_pot_front/features/domain/entities/token_pair.dart';

abstract class AuthRepository {
  Future<void> register({
    required String username,
    required String email,
    required String password,
  });
  Future<TokensPair> login({
    required String usernameOrEmail,
    required String password,
  });
}
