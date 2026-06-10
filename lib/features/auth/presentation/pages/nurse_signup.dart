import 'dart:io';
import 'package:cure/core/network/api_config.dart';
import 'package:cure/features/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/nav_button.dart';
import 'package:cure/features/auth/presentation/widgets/profile_photo_picker.dart';
import 'package:cure/features/auth/presentation/widgets/slide_header.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';
import 'package:cure/features/auth/domain/entities/nurse.dart';
import 'package:cure/core/di/injection.dart';
import 'package:cure/core/utils/result.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NurseSignupPage extends StatefulWidget {
  const NurseSignupPage({super.key});

  @override
  State<NurseSignupPage> createState() => _NurseSignupPageState();
}

class _NurseSignupPageState extends State<NurseSignupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? emailErrorText;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  final _skillsController = TextEditingController();

  late final PageController _pageController;
  int _currentPage = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _submitted = false;

  String? _selectedRegion;
  String? _selectedExperience;
  String? selectedGender;

  bool isImagePicked = false;
  String profileImagePath = 'default';

  void _onProfileImagePicked(String pickedPath) {
    setState(() {
      profileImagePath = pickedPath;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _skillsController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 3) {
      if (_validateCurrentSlide()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _submitForm();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentSlide() {
    setState(() {
      _submitted = true;
    });

    switch (_currentPage) {
      case 0:
        return (_validateName(_nameController.text) == null) &&
            (_validateEmail(_emailController.text) == null) &&
            (_validatePhone(_phoneController.text) == null) &&
            (_validatePassword(_passwordController.text) == null) &&
            (_validateConfirmPassword(_confirmPasswordController.text) == null);
      case 2:
        return (_validateExperience(_selectedExperience) == null) &&
            (_validateRegion(_selectedRegion) == null) &&
            (_validateSkills(_skillsController.text) == null);
      case 3:
        return (_validateDob(_dobController.text) == null) &&
            (_validateGender(selectedGender) == null);
      default:
        return true;
    }
  }

  Future<void> _submitForm() async {
    if (!_validateCurrentSlide()) {
      return;
    }

    setState(() {
      _submitted = true;
    });

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: LoadingWidget()),
    );

    try {
      final nurse = Nurse(
        id: '',
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        dateOfBirth: DateTime.parse(_dobController.text),
        gender: selectedGender ?? '',
        yearOfExperience: _selectedExperience,
        region: _selectedRegion,
        profileImageUrl: profileImagePath,
        skillSet: _skillsController.text.trim(),
      );

      final profileImageUrl = await uploadProfileImage(profileImagePath);
      if (profileImageUrl != null) {
        nurse.profileImageUrl = profileImageUrl;
      }

      final result = await di.authUseCase.nurseRegisterUseCase(
        nurse: nurse,
        password: _passwordController.text,
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (result is Success) {
        await _showSuccessAnimationAndNavigateToProfile();
      } else if (result is Failure) {
        final failure = result as Failure;
        final errorMessage = failure.error.toString();
        if (errorMessage.contains('email-already-in-use')) {
          setState(() {
            emailErrorText = S.of(context).errorUserAlreadyExists;
            _currentPage = 0;
            _pageController.jumpToPage(0);
          });
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
          setState(() {
            emailErrorText = S.of(context).invalidEmail;
            _currentPage = 0;
            _pageController.jumpToPage(0);
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      debugPrint('nurse signup failed: $e');
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
    if (value != _passwordController.text) {
      return S.of(context).errorPasswordMismatch;
    }
    return null;
  }

  String? _validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorExperienceRequired;
    }
    return null;
  }

  String? _validateRegion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorRegionRequired;
    }
    return null;
  }

  String? _validateSkills(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorSkillsRequired;
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
      _dobController.text =
          '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    }
  }

  Widget _buildAccountDetailsSlide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideHeader(
              title: S.of(context).accountDetailsHeaderTitle,
              subtitle: S.of(context).accountDetailsHeaderSubtitle,
            ),
            const SizedBox(height: 30),
            MyTextField(
              controller: _nameController,
              label: S.of(context).fullName,
              icon: Icons.person_outline_rounded,
              validator: _validateName,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _emailController,
              label: S.of(context).emailAddress,
              errorText: emailErrorText,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _phoneController,
              label: S.of(context).phoneNumberLabel,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _passwordController,
              label: S.of(context).passwordLabel,
              obscureText: _obscurePassword,
              onToggle: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              validator: _validatePassword,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _confirmPasswordController,
              label: S.of(context).confirmPasswordLabel,
              obscureText: _obscureConfirmPassword,
              onToggle: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              validator: _validateConfirmPassword,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
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
          .from('nurses_profile_images')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));

      final imageUrl = supabase.storage
          .from('nurses_profile_images')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      debugPrint('Upload failed: $e');
      return null;
    }
  }

  Widget _buildCareerInfoSlide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideHeader(
              title: S.of(context).careerDetailsHeaderTitle,
              subtitle: S.of(context).careerDetailsHeaderSubtitle,
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: _selectedExperience,
              decoration: InputDecoration(
                labelText: S.of(context).yearsOfExperience,
                prefixIcon: const Icon(Icons.workspace_premium_outlined),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'lessThanOne',
                  child: Text(S.of(context).experienceLessThanOneYear),
                ),
                DropdownMenuItem(
                  value: 'oneToThree',
                  child: Text(S.of(context).experience1to3Years),
                ),
                DropdownMenuItem(
                  value: 'threeToFive',
                  child: Text(S.of(context).experience3to5Years),
                ),
                DropdownMenuItem(
                  value: 'moreThanFive',
                  child: Text(S.of(context).experienceMoreThan5Years),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedExperience = value;
                });
              },
              validator: _validateExperience,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: _selectedRegion,
              decoration: InputDecoration(
                labelText: S.of(context).regionLabel,
                prefixIcon: const Icon(Icons.location_on_outlined),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'fayoumCity',
                  child: Text(S.of(context).regionFayoumCity),
                ),
                DropdownMenuItem(
                  value: 'itsa',
                  child: Text(S.of(context).regionItsa),
                ),
                DropdownMenuItem(
                  value: 'tamiya',
                  child: Text(S.of(context).regionTamiya),
                ),
                DropdownMenuItem(
                  value: 'youssefElSeddik',
                  child: Text(S.of(context).regionYoussefElSeddik),
                ),
                DropdownMenuItem(
                  value: 'snores',
                  child: Text(S.of(context).regionSnores),
                ),
                DropdownMenuItem(
                  value: 'other',
                  child: Text(S.of(context).regionOther),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
              validator: _validateRegion,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _skillsController,
              label: S.of(context).skillsSpecialties,
              icon: Icons.medical_services_outlined,
              maxLines: 3,
              validator: _validateSkills,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSlide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideHeader(
              title: S.of(context).personalDetailsHeaderTitle,
              subtitle: S.of(context).personalDetailsHeaderSubtitle,
            ),
            const SizedBox(height: 30),
            MyTextField(
              controller: _dobController,
              label: S.of(context).dateOfBirthLabel,
              readOnly: true,
              suffixIcon: Icons.calendar_month_outlined,
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
                  borderRadius: BorderRadius.circular(18),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.grey.shade300),
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
            const SizedBox(height: 28),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: AppPrimaryButton(
                  title: S.of(context).joinAsNurse,
                  onPressed: _submitForm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return GradientScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildAccountDetailsSlide(),
                  ProfilePhotoPicker(
                    imagePath: profileImagePath,
                    onImagePicked: _onProfileImagePicked,
                    page: 'nurse',
                  ),
                  _buildCareerInfoSlide(),
                  _buildPersonalInfoSlide(),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavButton(
                      icon: isRtl
                          ? Icons.chevron_right_rounded
                          : Icons.chevron_left_rounded,
                      enabled: _currentPage > 0,
                      onPressed: _goToPreviousPage,
                      isPrimary: false,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(4, (index) {
                        final isActive = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: isActive ? 1 : 0.35,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                    NavButton(
                      icon: _currentPage == 3
                          ? Icons.check_rounded
                          : (isRtl
                                ? Icons.chevron_left_rounded
                                : Icons.chevron_right_rounded),
                      enabled: true,
                      onPressed: _goToNextPage,
                      isPrimary: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
