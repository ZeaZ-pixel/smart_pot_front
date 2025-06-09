import 'package:smart_pot_front/features/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call({
    required String username,
    required String email,
    required String password,
  }) async {
    return repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
