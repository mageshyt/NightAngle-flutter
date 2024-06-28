import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:nightAngle/core/widgets/widgets.dart';
import 'package:nightAngle/features/auth/viewmodel/auth_viewmodel.dart';

import 'package:flutter/gestures.dart';
import 'package:nightAngle/core/core.dart';

import 'package:nightAngle/features/auth/view/widgets/auth_header.dart';
import 'package:nightAngle/features/auth/view/widgets/auth_button.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final form = FormGroup({
    'name': FormControl<String>(
        value: 'Magesh',
        validators: [Validators.required, Validators.minLength(3)]),
    'email': FormControl<String>(
        value: 'magesh@gmail.com',
        validators: [Validators.email, Validators.required]),
    'password': FormControl<String>(
      value: 'Password@',
      validators: [
        Validators.required,
        Validators.minLength(6),
        Validators.pattern(r'^(?=.*/?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            // show success message
            showSnackbar(
                context: context,
                title: 'Register',
                message: Texts.registerSuccess,
                contentType: ContentType.success);
            // navigate to login page
            context.go(Routes.login);
          },
          error: (err, stack) {
            showSnackbar(
                context: context,
                title: 'Auth',
                message: err.toString(),
                contentType: ContentType.failure);
          },
          loading: () {});
    });

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
                        onTap: () async {
                          // if not valid, stop
                          if (!form.valid) {
                            form.markAllAsTouched();
                            return;
                          }

                          final name = form.control('name').value;
                          final email = form.control('email').value;
                          final password = form.control('password').value;

                          ref.read(authViewModelProvider.notifier).registerUser(
                              name: name, email: email, password: password);
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
                                  context.go(Routes.login);
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
