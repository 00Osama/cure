import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/section_title.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class NurseSignupPage extends StatefulWidget {
  const NurseSignupPage({super.key});

  @override
  State<NurseSignupPage> createState() => _NurseSignupPageState();
}

class _NurseSignupPageState extends State<NurseSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _dobController = TextEditingController();

  final _skillsController = TextEditingController();

  String? _selectedRegion;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _submitted = false;

  String? _selectedExperience;
  String? selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).nurseSignupSuccess)));
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Image.asset('lib/assets/cure_logo.png', height: 180),
                const SizedBox(height: 24),
                Text(
                  S.of(context).nurseSignupTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7ED957),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).nurseSignupSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Color(0xFF7ED957)),
                ),

                const SizedBox(height: 32),
                SectionTitle(title: S.of(context).personalInformation),
                const SizedBox(height: 16),
                MyTextField(
                  controller: _nameController,
                  label: S.of(context).fullName,
                  icon: Icons.person_outline_rounded,
                  validator: _validateName,
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: _emailController,
                  label: S.of(context).emailAddress,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: _phoneController,
                  label: S.of(context).phoneNumberLabel,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),

                const SizedBox(height: 28),

                SectionTitle(title: S.of(context).accountSecurity),

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
                ),

                const SizedBox(height: 28),

                SectionTitle(title: S.of(context).professionalInformation),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: _selectedExperience,
                        decoration: InputDecoration(
                          labelText: S.of(context).yearsOfExperience,
                          prefixIcon: const Icon(
                            Icons.workspace_premium_outlined,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'lessThanOne',
                            child: Text(
                              S.of(context).experienceLessThanOneYear,
                            ),
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
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
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
                            borderRadius: BorderRadius.circular(16),
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
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                MyTextField(
                  controller: _skillsController,
                  label: S.of(context).skillsSpecialties,
                  icon: Icons.medical_services_outlined,
                  maxLines: 3,
                  validator: _validateSkills,
                ),

                const SizedBox(height: 28),

                SectionTitle(title: S.of(context).personalDetails),

                const SizedBox(height: 16),

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

                const SizedBox(height: 32),

                AppPrimaryButton(
                  title: S.of(context).joinAsNurse,
                  onPressed: _submitForm,
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
