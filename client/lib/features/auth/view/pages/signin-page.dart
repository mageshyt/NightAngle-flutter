import 'package:client/core/constants/constants.dart';
import 'package:client/core/core.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:reactive_forms/reactive_forms.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final form = FormGroup({
    'email': FormControl<String>(
        value: '', validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(value: '', validators: [
      Validators.required,
      Validators.pattern(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
    ]),
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // ------------- Header --------------
              const AuthHeader(
                title: Texts.loginTitle,
                subTitle: Texts.loginSubTitle,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              // ------------- Form --------------
              ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'email',
                      validationMessages: {
                        'required': (err) => 'Email is required.',
                        'email': (err) => 'Invalid email format.'
                      },
                      decoration: const InputDecoration(
                        hintText: Texts.emailHint,
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    ReactiveTextField(
                      formControlName: 'password',
                      validationMessages: {
                        'required': (err) => 'Password is required.',
                        'pattern': (err) =>
                            'Password must contain at least 8 characters'
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: Texts.passwordHint,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    AuthButton(
                      buttonText: 'Login',
                      onTap: () {
                        if (form.valid) {
                          print(form.value);
                        }
                      },
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // ------------- Sign Up --------------

                    RichText(
                      text: TextSpan(
                        text: Texts.dontHaveAccount,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Navigate to Sign Up Page
                              },
                            text: ' Sign Up',
                            style: const TextStyle(
                              color: Pallete.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
