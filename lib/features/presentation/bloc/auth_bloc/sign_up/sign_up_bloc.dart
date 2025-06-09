import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_pot_front/features/domain/usecase/register_user.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final RegisterUser registerUser;

  SignUpBloc(this.registerUser) : super(SignUpInitial()) {
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        await registerUser(
          username: event.username,
          email: event.email,
          password: event.password,
        );
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
