import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_pot_front/features/domain/repositories/verification_repository.dart';
import 'email_verification_event.dart';
import 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  final VerificationRepository repository;
  Timer? _resendTimer;
  int _secondsRemaining = 60;
  late Emitter _emit;

  EmailVerificationBloc(this.repository) : super(VerificationInitial()) {
    on<SendVerificationCode>(_onSendCode);
    on<ResendCodeRequested>(_onResendCode);
    on<VerifyCode>(_onVerifyCode);
  }

  Future<void> _onSendCode(SendVerificationCode event, Emitter emit) async {
    _emit = emit;
    emit(VerificationLoading());
    try {
      await repository.sendCode(event.email);
      _startResendCooldown();
    } catch (e) {
      emit(VerificationFailure(e.toString()));
    }
  }

  Future<void> _onResendCode(ResendCodeRequested event, Emitter emit) async {
    _emit = emit;
    try {
      await repository.sendCode(event.email);
      _startResendCooldown();
    } catch (e) {
      emit(VerificationFailure(e.toString()));
    }
  }

  Future<void> _onVerifyCode(VerifyCode event, Emitter emit) async {
    emit(VerificationLoading());
    try {
      await repository.verifyCode(email: event.email, code: event.code);
      emit(VerificationSuccess());
    } catch (e) {
      emit(VerificationFailure(e.toString()));
    }
  }

  void _startResendCooldown() {
    _secondsRemaining = 60;
    _emit(CodeSent(canResend: false, secondsRemaining: _secondsRemaining));
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _secondsRemaining--;
      if (_secondsRemaining <= 0) {
        timer.cancel();
        if (!_emit.isDone) {
          _emit(CodeSent(canResend: true, secondsRemaining: 0));
        }
      } else {
        if (!_emit.isDone) {
          _emit(
              CodeSent(canResend: false, secondsRemaining: _secondsRemaining));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
