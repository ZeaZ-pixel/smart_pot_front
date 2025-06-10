import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_pot_front/core/services/token_storage_service.dart';
import 'package:smart_pot_front/features/data/repositories/auth_repository_impl.dart';
import 'package:smart_pot_front/features/data/repositories/auth_token_repository_impl.dart';
import 'package:smart_pot_front/features/data/repositories/verification_repository_impl.dart';
import 'package:smart_pot_front/features/domain/repositories/auth_repository.dart';
import 'package:smart_pot_front/features/domain/repositories/auth_token_repository.dart';
import 'package:smart_pot_front/features/domain/repositories/verification_repository.dart';
import 'package:smart_pot_front/features/domain/usecase/login_user.dart';
import 'package:smart_pot_front/features/domain/usecase/register_user.dart';
import 'package:smart_pot_front/features/domain/usecase/save_auth_tokens.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => TokenStorageService());

  // Data
  sl.registerLazySingleton<AuthTokenRepository>(
      () => AuthTokenRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<VerificationRepository>(
      () => VerificationRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => SaveAuthTokens(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Blocs
  sl.registerFactory(() => SignUpBloc(sl()));
  sl.registerFactory(() => SignInBloc(sl(), sl()));
  sl.registerFactory(() => EmailVerificationBloc(sl(), sl()));
}
