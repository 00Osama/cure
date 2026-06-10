import 'dart:io';
import 'package:cure/features/profile/presentation/cubits/edit_profile_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/di/injection.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/utils/media_permission.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();
  final _skills = TextEditingController();

  bool _submitted = false;
  bool _fieldsInitialized = false;
  DateTime? _selectedDateOfBirth;
  String? _selectedGender;
  String? _selectedExperience;
  String? _selectedRegion;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _dob.dispose();
    _skills.dispose();
    super.dispose();
  }

  Future<void> _save(BuildContext context) async {
    setState(() {
      _submitted = true;
    });

    if (!_formKey.currentState!.validate()) return;

    await context.read<EditProfileInfoCubit>().saveProfile(
      name: _name.text,
      phoneNumber: _phone.text,
      dateOfBirth: _selectedDateOfBirth!,
      gender: _selectedGender!,
      yearOfExperience: _selectedExperience,
      region: _selectedRegion,
      skillSet: _skills.text,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickDateOfBirth() async {
    final initialDate =
        _selectedDateOfBirth ??
        DateTime.now().subtract(const Duration(days: 365 * 18));
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );

    if (selectedDate == null) return;
    setState(() {
      _selectedDateOfBirth = selectedDate;
      _dob.text = _formatDate(selectedDate);
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorRequired;
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

  String? _validateDob(String? value) {
    if (_selectedDateOfBirth == null || value == null || value.trim().isEmpty) {
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

  ImageProvider? _imageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    }
    if (imagePath != 'default' &&
        imagePath.isNotEmpty &&
        File(imagePath).existsSync()) {
      return FileImage(File(imagePath));
    }
    return null;
  }

  Future<void> _pickProfileImage(BuildContext context) async {
    final permission = await MediaPermission.requestGalleryAccess();
    if (!context.mounted) return;

    if (permission == MediaPermissionResult.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).storagePermissionDenied)),
      );
      return;
    }
    if (permission == MediaPermissionResult.permanentlyDenied) {
      await MediaPermission.showOpenSettingsDialog(context);
      return;
    }

    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
      maxWidth: 1600,
    );
    if (picked == null || !context.mounted) return;

    context.read<EditProfileInfoCubit>().selectProfileImage(picked.path);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);

    return BlocProvider(
      create: (_) => di.createEditProfileInfoCubit()..loadProfile(),
      child: BlocConsumer<EditProfileInfoCubit, EditProfileInfoState>(
        listener: (context, state) {
          final profile = state.profile;
          if (profile != null && !_fieldsInitialized) {
            _fieldsInitialized = true;
            _name.text = profile.name;
            _phone.text = profile.phoneNumber ?? '';
            _email.text = profile.email;
            _selectedDateOfBirth = profile.dateOfBirth;
            _dob.text = _formatDate(profile.dateOfBirth);
            _selectedGender = profile.gender;
            _selectedExperience = profile.yearOfExperience;
            _selectedRegion = profile.region;
            _skills.text = profile.skillSet ?? '';
          }

          if (state.status == EditProfileInfoStatus.saved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(s.profileUpdated),
                backgroundColor: colors.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          }

          if (state.status == EditProfileInfoStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(s.errorUnexpected),
                backgroundColor: colors.danger,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final imageProvider = _imageProvider(state.imagePath);

          return GradientScaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(s.editProfile),
            ),
            body: state.isLoading && state.profile == null
                ? const Center(child: LoadingWidget())
                : Form(
                    key: _formKey,
                    autovalidateMode: _submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: state.isSaving
                                ? null
                                : () => _pickProfileImage(context),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundColor: colors.surfaceHigh,
                                  backgroundImage: imageProvider,
                                  child: imageProvider == null
                                      ? Icon(
                                          Icons.person_rounded,
                                          size: 56,
                                          color: colors.onSurfaceSubtle,
                                        )
                                      : null,
                                ),
                                if (state.isSaving)
                                  Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: .30,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(child: LoadingWidget()),
                                  ),
                                PositionedDirectional(
                                  end: 8,
                                  bottom: 10,
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: colors.surface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: colors.border),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: colors.onSurface,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        MyTextField(
                          controller: _name,
                          label: s.fullName,
                          icon: Icons.person_outline,
                          validator: _validateName,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          controller: _email,
                          label: s.emailAddress,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          controller: _phone,
                          label: s.phoneNumberLabel,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          controller: _dob,
                          label: s.dateOfBirthLabel,
                          icon: Icons.cake_outlined,
                          suffixIcon: Icons.calendar_month_outlined,
                          readOnly: true,
                          onTap: _pickDateOfBirth,
                          validator: _validateDob,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedGender,
                          decoration: InputDecoration(
                            labelText: s.genderLabel,
                            prefixIcon: const Icon(Icons.wc_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          validator: _validateGender,
                          items: [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text(s.maleLabel),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text(s.femaleLabel),
                            ),
                          ],
                          onChanged: state.isSaving
                              ? null
                              : (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                        ),
                        if (state.profile?.role == 'nurse') ...[
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _selectedExperience,
                            decoration: InputDecoration(
                              labelText: s.yearsOfExperience,
                              prefixIcon: const Icon(
                                Icons.workspace_premium_outlined,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            validator: _validateExperience,
                            items: [
                              DropdownMenuItem(
                                value: 'lessThanOne',
                                child: Text(s.experienceLessThanOneYear),
                              ),
                              DropdownMenuItem(
                                value: 'oneToThree',
                                child: Text(s.experience1to3Years),
                              ),
                              DropdownMenuItem(
                                value: 'threeToFive',
                                child: Text(s.experience3to5Years),
                              ),
                              DropdownMenuItem(
                                value: 'moreThanFive',
                                child: Text(s.experienceMoreThan5Years),
                              ),
                            ],
                            onChanged: state.isSaving
                                ? null
                                : (value) {
                                    setState(() {
                                      _selectedExperience = value;
                                    });
                                  },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _selectedRegion,
                            decoration: InputDecoration(
                              labelText: s.regionLabel,
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            validator: _validateRegion,
                            items: [
                              DropdownMenuItem(
                                value: 'fayoumCity',
                                child: Text(s.regionFayoumCity),
                              ),
                              DropdownMenuItem(
                                value: 'itsa',
                                child: Text(s.regionItsa),
                              ),
                              DropdownMenuItem(
                                value: 'tamiya',
                                child: Text(s.regionTamiya),
                              ),
                              DropdownMenuItem(
                                value: 'youssefElSeddik',
                                child: Text(s.regionYoussefElSeddik),
                              ),
                              DropdownMenuItem(
                                value: 'snores',
                                child: Text(s.regionSnores),
                              ),
                              DropdownMenuItem(
                                value: 'other',
                                child: Text(s.regionOther),
                              ),
                            ],
                            onChanged: state.isSaving
                                ? null
                                : (value) {
                                    setState(() {
                                      _selectedRegion = value;
                                    });
                                  },
                          ),
                          const SizedBox(height: 16),
                          MyTextField(
                            controller: _skills,
                            label: s.skillsSpecialties,
                            icon: Icons.medical_services_outlined,
                            maxLines: 3,
                            validator: _validateSkills,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                        const SizedBox(height: 28),
                        state.isSaving
                            ? const Center(child: LoadingWidget())
                            : AppPrimaryButton(
                                title: s.save,
                                onPressed: () => _save(context),
                              ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
