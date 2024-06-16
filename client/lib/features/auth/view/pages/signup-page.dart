import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:nightAngle/features/auth/view/widgets/auth_header.dart';
import 'package:nightAngle/features/auth/view/widgets/auth_button.dart';
import 'package:flutter/gestures.dart';
import 'package:nightAngle/core/core.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final form = FormGroup({
    'name': FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(3)]),
    'email': FormControl<String>(
        value: '', validators: [Validators.email, Validators.required]),
    'password': FormControl<String>(
      value: '',
      validators: [
        Validators.required,
        Validators.minLength(6),
        Validators.pattern(r'^(?=.*/?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: SpacingStyle.paddingWithAppBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // ------------- Header --------------
                const AuthHeader(
                    title: Texts.signupTitle, subTitle: Texts.signupSubtitle),

                const SizedBox(height: Sizes.spaceBtwItems),

                const SizedBox(height: Sizes.spaceBtwSections),
                // -------------- Form Field --------------
                ReactiveForm(
                  formGroup: form,
                  child: Column(
                    children: [
                      // -------------- Name Field --------------
                      ReactiveTextField<String>(
                        formControlName: 'name',
                        validationMessages: {
                          'required': (err) => 'Name is required.',
                          'minLength': (err) =>
                              'Name must be at least 3 characters.'
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: Texts.userHint,
                        ),
                      ),

                      const SizedBox(height: Sizes.spaceBtwInputFields),

                      // -------------- Email Field --------------
                      ReactiveTextField<String>(
                        formControlName: 'email',
                        validationMessages: {
                          'required': (err) => 'Email is required.',
                          'email': (err) => 'Invalid email format.'
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: Texts.emailHint,
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),
                      // -------------- Password Field --------------
                      ReactiveTextField<String>(
                        obscureText: true,
                        formControlName: 'password',
                        validationMessages: {
                          'required': (err) => 'Password is required.',
                          'minLength': (err) =>
                              'Password must be at least 6 characters.',
                          'pattern': (err) =>
                              'Password must contain at least 1 uppercase, 1 lowercase, 1 number and 8 characters.'
                        },
                        decoration: const InputDecoration(
                          alignLabelWithHint: false,
                          hintText: Texts.passwordHint,
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwSections),

                      AuthButton(
                        buttonText: 'Sign Up',
                        onTap: () {
                          if (form.valid) {
                            print(form.value);
                          }
                        },
                      ),

                      const SizedBox(height: Sizes.spaceBtwSections),

                      RichText(
                        text: TextSpan(
                          text: Texts.alreadyHaveAccount,
                          style: const TextStyle(
                            color: Pallete.textSecondary,
                            fontSize: Sizes.fontSizeMd,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.goNamed(Routes.login);
                                },
                              text: ' login',
                              style: const TextStyle(
                                color: Pallete.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
