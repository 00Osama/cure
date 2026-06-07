import 'dart:io';
import 'package:cure/core/network/api_config.dart';
import 'package:cure/features/auth/domain/entities/patient.dart';
import 'package:cure/features/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/profile_photo_picker.dart';
import 'package:cure/features/auth/presentation/widgets/slide_header.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/di/injection.dart';
import 'package:cure/shared/utils/result.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:cure/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  String profileImagePath = 'default';

  void _onProfileImagePicked(String pickedPath) {
    setState(() {
      profileImagePath = pickedPath;
    });
  }

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

  Future<void> _showSuccessAnimationAndNavigateToProfile() async {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const SizedBox(),
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          body: Center(child: Lottie.asset('lib/assets/animations/bomb.json')),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: const SizedBox(),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: Lottie.asset('lib/assets/animations/success.json'),
            ),
          );
        },
      );
      Future.delayed(const Duration(milliseconds: 2200), () {
        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavBar()),
        );
      });
    });
  }

  Future<String?> uploadProfileImage(String imagePath) async {
    // No image picked, or Supabase not configured — skip upload.
    if (imagePath.isEmpty || imagePath == 'default') return null;
    if (!ApiConfig.hasAnonKey) return null;
    try {
      final supabase = Supabase.instance.client;
      final file = File(imagePath);

      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage
          .from('patients_profile_images')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));

      final imageUrl = supabase.storage
          .from('patients_profile_images')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }

  void _submitForm() async {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      // Show loading indicator
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: LoadingWidget()),
      );

      try {
        // Create Patient entity with form data
        final patient = Patient(
          id: '', // Will be assigned by backend
          name: nameController.text.trim(),
          profileImageUrl: 'default',
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          dateOfBirth: DateTime.parse(dobController.text),
          gender: selectedGender ?? '',
        );

        final profileImageUrl = await uploadProfileImage(profileImagePath);
        if (profileImageUrl != null) {
          patient.profileImageUrl = profileImageUrl;
        }
        patient.profileImageUrl = profileImageUrl ?? 'default';

        // Call signup firebase
        final result = await di.authUseCase.patientRegisterUseCase(
          patient: patient,
          password: passwordController.text,
        );

        if (!mounted) return;
        Navigator.pop(context); // Close loading dialog

        // Handle result
        if (result is Success) {
          await _showSuccessAnimationAndNavigateToProfile();
        } else if (result is Failure) {
          final failure = result as Failure;
          final errorMessage = failure.error.toString();
          if (errorMessage.contains('email-already-in-use')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  S.of(context).errorUserAlreadyExists,
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
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
          }

          debugPrint('Signup failed: ${failure.error}');
        }
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context); // Close loading dialog
        debugPrint('patient signup failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).errorUnexpected,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (_validateName(nameController.text) != null ||
          _validateEmail(emailController.text) != null ||
          _validatePhone(phoneController.text) != null ||
          _validatePassword(passwordController.text) != null ||
          _validateConfirmPassword(confirmPasswordController.text) != null ||
          _validateDob(dobController.text) != null ||
          _validateGender(selectedGender) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).makeSure,
              style: const TextStyle(color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
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
                Image.asset(
                  'lib/assets/images/crop_cure_logo.png',
                  height: 140,
                ),
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

                SlideHeader(
                  title: S.of(context).accountDetailsHeaderTitle,
                  subtitle: S.of(context).accountDetailsHeaderSubtitle,
                ),
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

                const SizedBox(height: 16),
                ProfilePhotoPicker(
                  imagePath: profileImagePath,
                  onImagePicked: _onProfileImagePicked,
                  page: 'patient',
                ),
                const SizedBox(height: 16),

                SlideHeader(
                  title: S.of(context).personalDetailsHeaderTitle,
                  subtitle: S.of(context).personalDetailsHeaderSubtitle,
                ),
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
