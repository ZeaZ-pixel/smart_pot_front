import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/assets/app_images.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';
import 'package:smart_pot_front/core/widgets/custom_form_input.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

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
                    context.go(AppRoutes.authSignUp);
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
                  ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState?.validate() ?? false;
                      if (!isValid) return;
                    },
                    child: Text('Авторизироваться'),
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
