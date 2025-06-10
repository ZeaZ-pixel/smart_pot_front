import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/dependency_injection.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_event.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/email_verification/email_verification_state.dart';

class EmailVerificationPage extends HookWidget {
  final String email;
  const EmailVerificationPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController();

    useEffect(() {
      Future.microtask(() {
        context.read<EmailVerificationBloc>().add(SendVerificationCode(email));
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: Text('Подтверждение Email')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
          listener: (context, state) {
            if (state is VerificationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Регистрация успешна')),
              );
              context.go(AppRoutes.home);
            } else if (state is VerificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Код отправлен на $email'),
                SizedBox(height: 24),
                PinCodeTextField(
                  appContext: context,
                  controller: codeController,
                  length: 6,
                  onChanged: (_) {},
                  onCompleted: (code) {
                    context.read<EmailVerificationBloc>().add(
                          VerifyCode(email: email, code: code),
                        );
                  },
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24),
                if (state is VerificationLoading) CircularProgressIndicator(),
                if (state is VerificationFailure)
                  Text(state.error, style: TextStyle(color: Colors.red)),
                if (state is CodeSent)
                  state.canResend
                      ? TextButton(
                          onPressed: () => context
                              .read<EmailVerificationBloc>()
                              .add(ResendCodeRequested(email)),
                          child: Text('Отправить код повторно'),
                        )
                      : Text(
                          'Отправить повторно можно через ${state.secondsRemaining} сек'),
              ],
            );
          },
        ),
      ),
    );
  }
}
