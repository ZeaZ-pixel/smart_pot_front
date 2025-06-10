abstract class SignInEvent {}

class SignInSubmitted extends SignInEvent {
  final String usernameOrEmail;
  final String password;

  SignInSubmitted({
    required this.usernameOrEmail,
    required this.password,
  });
}
