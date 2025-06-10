import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/assets/app_images.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';
import 'package:smart_pot_front/core/widgets/custom_form_input.dart';
import 'package:smart_pot_front/core/widgets/custom_loader.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_in/sign_in_event.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_in/sign_in_state.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final usernameOrEmailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.authBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Логин',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 5,
              children: [
                Text(
                  'У Вас нет аккаунта?',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.authSignIn);
                  },
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomFormInput(
                    label: 'Username/Email',
                    controller: usernameOrEmailController,
                    placeholder: 'ВВедите email или username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите email';
                      }
                      if (value.length < 3) {
                        return 'Username должен быть минимум 3 символа';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomFormInput(
                    label: 'Пароль',
                    placeholder: 'Пароль',
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Пароль должен содержать минимум 6 символов';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state is SignInSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Авторизация успешна')),
                        );
                        context.go(AppRoutes.home);
                      } else if (state is SignInFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) => ElevatedButton(
                      onPressed: state is SignInLoading
                          ? null
                          : () {
                              final isValid =
                                  formKey.currentState?.validate() ?? false;
                              if (!isValid) return;

                              context.read<SignInBloc>().add(
                                    SignInSubmitted(
                                      usernameOrEmail:
                                          usernameOrEmailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            },
                      child: state is SignInLoading
                          ? CustomLoader()
                          : Text('Авторизация'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
