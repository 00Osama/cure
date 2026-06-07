import 'package:flutter/material.dart';

import 'package:cure/features/auth/data/models/user_model.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/di/injection.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:cure/shared/widgets/loading_widget.dart';

/// Loads the signed-in user's profile, lets them edit name + phone, and saves
/// back to Firestore. Email is shown read-only (it is tied to the auth account).
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

  String _imageUrl = 'default';
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final uid = di.currentUid;
    UserModel? user;
    if (uid != null) {
      try {
        user = await di.profileRemoteDataSource.getProfileById(uid);
      } catch (_) {
        // Leave fields empty on failure; the form still works.
      }
    }
    if (!mounted) return;
    setState(() {
      _name.text = user?.name ?? '';
      _phone.text = user?.phoneNumber ?? '';
      _email.text = user?.email ?? '';
      _imageUrl = user?.profileImagePath ?? 'default';
      _loading = false;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final uid = di.currentUid;
    if (uid == null) return;

    final messenger = ScaffoldMessenger.of(context);
    final l10n = S.of(context);
    setState(() => _saving = true);
    try {
      await di.profileRemoteDataSource.updateProfileFields(uid, {
        'name': _name.text.trim(),
        'phone_number': _phone.text.trim(),
      });
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.profileUpdated),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.errorUnexpected),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final hasImage = _imageUrl.startsWith('http');

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.editProfile),
      ),
      body: _loading
          ? const Center(child: LoadingWidget())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.white12,
                      backgroundImage:
                          hasImage ? NetworkImage(_imageUrl) : null,
                      child: hasImage
                          ? null
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white70,
                            ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  MyTextField(
                    controller: _name,
                    label: s.fullName,
                    icon: Icons.person_outline,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? s.errorRequired
                        : null,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: _phone,
                    label: s.phoneNumberLabel,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: _email,
                    label: s.emailAddress,
                    icon: Icons.email_outlined,
                    readOnly: true,
                  ),
                  const SizedBox(height: 28),
                  _saving
                      ? const Center(child: LoadingWidget())
                      : AppPrimaryButton(title: s.save, onPressed: _save),
                ],
              ),
            ),
    );
  }
}
