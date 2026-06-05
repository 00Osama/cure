import 'package:cure/features/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/di/injection.dart';
import 'package:cure/shared/utils/result.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:cure/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitted = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    setState(() {
      _submitted = true;
    });

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: LoadingWidget()),
    );

    try {
      final result = await di.authUseCase.signInUseCase(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (result is Success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BottomNavBar()),
        );
      } else if (result is Failure) {
        final failure = result as Failure;
        final errorMessage = failure.error.toString();
        if (errorMessage.contains('user-not-found')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context).errorUserNotFoundAfterSignIn,
                style: const TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        } else if (errorMessage.contains('wrong-password')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context).errorWrongPassword,
                style: const TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context).errorUnexpected,
                style: const TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return S.of(context).errorInvalidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorRequired;
    }
    if (value.length < 6) {
      return S.of(context).errorInvalidPassword;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Image.asset('lib/assets/images/crop_cure_logo.png', height: 140),
              const SizedBox(height: 24),
              Text(
                S.of(context).welcomeBackTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF7ED957),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                S.of(context).signInToContinue,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF7ED957),
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                autovalidateMode: _submitted
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    MyTextField(
                      controller: _emailController,
                      label: S.of(context).emailAddress,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      controller: _passwordController,
                      label: S.of(context).passwordLabel,
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: _validatePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: AppPrimaryButton(
                        title: S.of(context).signInButtonLabel,
                        onPressed: _submitForm,
                      ),
                    ),
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
