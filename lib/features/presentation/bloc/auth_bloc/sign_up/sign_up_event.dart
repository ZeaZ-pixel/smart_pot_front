abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String username;
  final String email;
  final String password;

  SignUpSubmitted({
    required this.username,
    required this.email,
    required this.password,
  });
}
