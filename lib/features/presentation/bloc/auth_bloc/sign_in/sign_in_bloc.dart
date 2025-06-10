import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_pot_front/features/domain/usecase/login_user.dart';
import 'package:smart_pot_front/features/domain/usecase/save_auth_tokens.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final LoginUser loginUser;
  final SaveAuthTokens saveAuthTokens;

  SignInBloc(this.loginUser, this.saveAuthTokens) : super(SignInInitial()) {
    on<SignInSubmitted>((event, emit) async {
      emit(SignInLoading());
      try {
        final tokensPair = await loginUser(
          usernameOrEmail: event.usernameOrEmail,
          password: event.password,
        );
        saveAuthTokens(
            accessToken: tokensPair.accessToken,
            refreshToken: tokensPair.accessToken);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(e.toString()));
      }
    });
  }
}
