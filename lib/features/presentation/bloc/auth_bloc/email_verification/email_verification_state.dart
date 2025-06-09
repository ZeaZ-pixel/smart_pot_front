abstract class EmailVerificationState {}

class VerificationInitial extends EmailVerificationState {}

class CodeSent extends EmailVerificationState {
  final bool canResend;
  final int secondsRemaining;
  CodeSent({required this.canResend, required this.secondsRemaining});
}

class VerificationLoading extends EmailVerificationState {}

class VerificationSuccess extends EmailVerificationState {}

class VerificationFailure extends EmailVerificationState {
  final String error;
  VerificationFailure(this.error);
}
