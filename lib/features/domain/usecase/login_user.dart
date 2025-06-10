import 'package:smart_pot_front/features/domain/entities/token_pair.dart';
import 'package:smart_pot_front/features/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<TokensPair> call({
    required String usernameOrEmail,
    required String password,
  }) async {
    return repository.login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );
  }
}
