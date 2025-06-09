abstract class EmailVerificationEvent {}

class SendVerificationCode extends EmailVerificationEvent {
  final String email;
  SendVerificationCode(this.email);
}

class VerifyCode extends EmailVerificationEvent {
  final String email;
  final String code;
  VerifyCode({required this.email, required this.code});
}

class ResendCodeRequested extends EmailVerificationEvent {
  final String email;
  ResendCodeRequested(this.email);
}
