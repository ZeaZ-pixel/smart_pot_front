import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_pot_front/config/routes/app_router.dart';
import 'package:smart_pot_front/config/themes/app_theme.dart';
import 'package:smart_pot_front/dependency_injection.dart' as di;
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(create: (_) => di.sl<SignUpBloc>()),
        BlocProvider<EmailVerificationBloc>(
          create: (_) => di.sl<EmailVerificationBloc>(),
        ),
        BlocProvider<SignInBloc>(
          create: (_) => di.sl<SignInBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
