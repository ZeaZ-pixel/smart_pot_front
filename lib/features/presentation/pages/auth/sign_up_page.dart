import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_pot_front/config/assets/app_images.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';
import 'package:smart_pot_front/core/widgets/custom_form_input.dart';
import 'package:smart_pot_front/core/widgets/custom_loader.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_event.dart';
import 'package:smart_pot_front/features/presentation/bloc/auth_bloc/sign_up/sign_up_state.dart';

class SignUpPage extends HookWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.authBg),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Регистрация успешна')),
              );
              final email = emailController.text.trim();
              context.go(AppRoutes.authEmailVerify, extra: email);
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  'Регистрация',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 5,
                  children: [
                    Text(
                      'У Вас уже есть аккаунт?',
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
                        'Авторизируйтесь',
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
                SizedBox(height: 25),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormInput(
                        controller: usernameController,
                        label: 'Username',
                        placeholder: 'Введите Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите Username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomFormInput(
                        controller: emailController,
                        label: 'Email',
                        placeholder: 'Введите email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите email';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Введите корректный email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomFormInput(
                        controller: passwordController,
                        label: 'Пароль',
                        placeholder: 'Пароль',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          if (value.length < 6) {
                            return 'Минимум 6 символов';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomFormInput(
                        controller: repeatPasswordController,
                        label: 'Повторите пароль',
                        placeholder: 'Пароль',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          if (value != passwordController.text) {
                            return 'Пароли не совпадают';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state is SignUpLoading
                              ? null
                              : () {
                                  final isValid =
                                      formKey.currentState?.validate() ?? false;
                                  if (!isValid) return;

                                  context
                                      .read<SignUpBloc>()
                                      .add(SignUpSubmitted(
                                        username:
                                            usernameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ));
                                },
                          child: state is SignUpLoading
                              ? CustomLoader()
                              : Text('Зарегистрироваться'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
