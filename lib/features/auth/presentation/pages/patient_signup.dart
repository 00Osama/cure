import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/section_title.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool _submitted = false;

  String? selectedGender;

  Future<void> _pickDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );

    if (selectedDate != null) {
      dobController.text =
          '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).patientSignupSuccess)),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorRequired;
    }
    return null;
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

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorRequired;
    }
    final phoneRegex = RegExp(r'^(011|012|010|015)[0-9]{8}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return S.of(context).errorInvalidPhone;
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorRequired;
    }
    if (value != passwordController.text) {
      return S.of(context).errorPasswordMismatch;
    }
    return null;
  }

  String? _validateDob(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorInvalidDOB;
    }
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorSelectGender;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _submitted
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Image.asset('lib/assets/cure_logo.png', height: 180),
                const SizedBox(height: 24),
                Text(
                  S.of(context).patientSignupTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7ED957),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).patientSignupSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Color(0xFF7ED957)),
                ),

                const SizedBox(height: 32),

                SectionTitle(title: S.of(context).personalInformation),

                const SizedBox(height: 16),

                MyTextField(
                  controller: nameController,
                  label: S.of(context).fullName,
                  icon: Icons.person_outline_rounded,
                  validator: _validateName,
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: emailController,
                  label: S.of(context).emailAddress,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: phoneController,
                  label: S.of(context).phoneNumberLabel,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),

                const SizedBox(height: 28),

                SectionTitle(title: S.of(context).accountSecurity),

                const SizedBox(height: 16),

                MyTextField(
                  controller: passwordController,
                  label: S.of(context).passwordLabel,
                  obscureText: obscurePassword,
                  onToggle: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  validator: _validatePassword,
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: confirmPasswordController,
                  label: S.of(context).confirmPasswordLabel,
                  obscureText: obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: 28),

                SectionTitle(title: S.of(context).personalDetails),

                const SizedBox(height: 16),

                MyTextField(
                  keyboardType: TextInputType.datetime,
                  controller: dobController,
                  label: S.of(context).dateOfBirthLabel,
                  suffixIcon: Icons.calendar_month_outlined,
                  readOnly: true,
                  onTap: _pickDateOfBirth,
                  validator: _validateDob,
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: selectedGender,
                  decoration: InputDecoration(
                    labelText: S.of(context).genderLabel,
                    prefixIcon: const Icon(Icons.wc_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: _validateGender,
                  items: [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text(S.of(context).maleLabel),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text(S.of(context).femaleLabel),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),

                const SizedBox(height: 32),

                AppPrimaryButton(
                  onPressed: _submitForm,
                  title: S.of(context).joinAsPatient,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
