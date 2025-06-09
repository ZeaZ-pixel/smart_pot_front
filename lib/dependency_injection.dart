import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_pot_front/features/data/repositories/auth_repository_impl.dart';
import 'package:smart_pot_front/features/data/repositories/verification_repository_impl.dart';
import 'package:smart_pot_front/features/domain/repositories/auth_repository.dart';
import 'package:smart_pot_front/features/domain/repositories/verification_repository.dart';
import 'package:smart_pot_front/features/domain/usecase/register_user.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerFactory(() => SignUpBloc(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<VerificationRepository>(
      () => VerificationRepositoryImpl(sl()));
  sl.registerFactory(() => EmailVerificationBloc(sl()));

  sl.registerLazySingleton(() => Dio());
}
