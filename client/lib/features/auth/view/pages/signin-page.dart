import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fpdart/fpdart.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:nightAngle/core/core.dart';

import 'package:nightAngle/features/auth/repositories/auth_remote_repository.dart';
import 'package:nightAngle/features/auth/view/widgets/auth_button.dart';
import 'package:nightAngle/features/auth/view/widgets/auth_header.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final form = FormGroup({
    'email': FormControl<String>(
        value: 'magesh@gmail.com',
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(value: 'Password@123', validators: [
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
                      onTap: () async {
                        // if not valid, stop
                        if (!form.valid) {
                          form.markAllAsTouched();
                          return;
                        }
                        final email = form.control('email').value;
                        final password = form.control('password').value;

                        final res = await AuthRemoteRepository()
                            .login(email: email, password: password);

                        final val = switch (res) {
                          Left(value: final l) => l,
                          Right(value: final r) => r,
                        };

                        print(val);
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
                                context.goNamed(Routes.register);
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
