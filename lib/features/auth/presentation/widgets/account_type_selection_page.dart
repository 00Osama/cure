import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/auth/presentation/pages/nurse_signup.dart';
import 'package:cure/features/auth/presentation/pages/patient_signup.dart';
import 'package:cure/features/auth/presentation/pages/signin.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/features/auth/presentation/widgets/account_type_button.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AccountTypeSelectionPage extends StatefulWidget {
  const AccountTypeSelectionPage({super.key});

  @override
  State<AccountTypeSelectionPage> createState() =>
      _AccountTypeSelectionPageState();
}

class _AccountTypeSelectionPageState extends State<AccountTypeSelectionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onPatientSelected() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PatientSignupPage()),
    );
  }

  void _onNurseSelected() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NurseSignupPage()),
    );
  }

  void _onSignInSelected() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Signin()));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return GradientScaffold(
      body: Stack(
        children: [
          // Animated content
          FadeTransition(
            opacity: _fadeController,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        s.selectAccountType,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.of(context).onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        s.selectAccountTypeDesc,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.of(
                            context,
                          ).onSurface.withValues(alpha: 0.7),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 56),
                      // Patient button
                      AccountTypeButton(
                        color: const Color(0xFF26E8F3).withValues(alpha: 0.2),
                        icon: '😷',
                        title: s.patientButton,
                        subtitle: s.patientButtonSubtitle,
                        onTap: _onPatientSelected,
                      ),
                      const SizedBox(height: 28),
                      // Nurse button
                      AccountTypeButton(
                        color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                        icon: '👨‍⚕️',
                        title: s.nurseButton,
                        subtitle: s.nurseButtonSubtitle,
                        onTap: _onNurseSelected,
                      ),
                      const SizedBox(height: 28),
                      // already have an account
                      AccountTypeButton(
                        color: const Color(0xFF26E8F3).withValues(alpha: 0.2),
                        icon: '💡',
                        title: s.alreadyHaveAccount,
                        subtitle: s.alreadyHaveAccountSubtitle,
                        onTap: _onSignInSelected,
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
