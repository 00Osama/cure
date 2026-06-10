import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/theme_and_locals/locals_cubit.dart';
import 'package:cure/core/theme_and_locals/them_cubit.dart';
import 'package:cure/features/auth/presentation/pages/onbording_page.dart';
import 'package:cure/features/profile/presentation/pages/edit_profile.dart';
import 'package:cure/features/profile/presentation/pages/theme_and_language.dart';
import 'package:cure/features/profile/presentation/widgets/circle_avatar.dart';
import 'package:cure/features/profile/presentation/widgets/notification_tile.dart';
import 'package:cure/features/profile/presentation/widgets/profile_title.dart';
import 'package:cure/features/profile/presentation/widgets/settings_section.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/di/injection.dart';
import 'package:cure/core/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  bool isDark = false;
  bool isArabic = false;
  String _name = '';
  String _profileImagePath = 'default';
  String _role = 'patient';
  bool _profileLoading = true;

  String _roleLabel(BuildContext context) {
    return _role.toLowerCase() == 'nurse'
        ? S.of(context).nurse
        : S.of(context).patient;
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _profileLoading = false);
      return;
    }

    try {
      final profile = await di.profileRemoteDataSource.getProfileById(uid);
      if (!mounted) return;
      setState(() {
        _name = profile?.name ?? '';
        _profileImagePath = profile?.profileImagePath ?? 'default';
        _role = profile?.role ?? 'patient';
        _profileLoading = false;
      });
    } catch (e) {
      debugPrint('load profile failed: $e');
      if (mounted) setState(() => _profileLoading = false);
    }
  }

  ImageProvider? _profileImageProvider() {
    if (_profileImagePath.startsWith('http')) {
      return NetworkImage(_profileImagePath);
    }
    if (_profileImagePath != 'default' &&
        _profileImagePath.isNotEmpty &&
        File(_profileImagePath).existsSync()) {
      return FileImage(File(_profileImagePath));
    }
    return null;
  }

  Future<bool?> profileDialog(
    BuildContext context,
    String title,
    String message,
    String confirmText,
    String cancelText,
    IconData? icon,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        final colors = AppColors.of(context);
        return Dialog(
          backgroundColor: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.danger.withValues(alpha: .15),
                  ),
                  child: Icon(icon, color: colors.danger, size: 34),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.onSurfaceMuted),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.border),
                        ),
                        child: Text(cancelText),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.danger,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> deleteAccount(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = S.of(context);
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return false;
      }

      final uid = user.uid;

      // delete user data from Firestore
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: uid)
          .get();

      for (final doc in query.docs) {
        await doc.reference.delete();
      }
      await user.delete();

      // logout
      await FirebaseAuth.instance.signOut();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.reauthRequiredToDelete)),
        );
      }
      return false;
    } catch (e) {
      debugPrint('delete account failed: $e');
      messenger.showSnackBar(SnackBar(content: Text(l10n.errorUnexpected)));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).profile,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            ProfileAvatar(
              imageProvider: _profileImageProvider(),
              loading: _profileLoading,
            ),

            if (!_profileLoading) ...[
              Text(
                _name.isEmpty ? S.of(context).profile : _name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: colors.accent.withValues(alpha: .28),
                  ),
                ),
                child: Text(
                  _roleLabel(context),
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Account
            SettingsSection(
              title: S.of(context).account,
              children: [
                SettingsTile(
                  icon: Icons.edit_outlined,
                  title: S.of(context).editProfile,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfile()),
                    );
                    if (!mounted) return;
                    _loadProfile();
                  },
                ),
                Divider(height: 1, color: colors.border),
                SettingsTile(
                  icon: Icons.delete_outline,
                  title: S.of(context).deleteAccount,
                  textColor: colors.danger,
                  onTap: () async {
                    final l10n = S.of(context);
                    final confirmed = await profileDialog(
                      context,
                      l10n.deleteAccount,
                      l10n.deleteAccountDialogMessage,
                      l10n.confirm,
                      l10n.cancel,
                      Icons.delete_outline,
                    );
                    if (!context.mounted) return;
                    if (confirmed != true) return;

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: LoadingWidget()),
                    );

                    final deleted = await deleteAccount(context);

                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();

                    if (deleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: colors.success,
                          content: Text(
                            l10n.accountDeleted,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    if (deleted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnBordingPage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return BlocBuilder<LanguageCubit, LanguageState>(
                  builder: (context, languageState) {
                    return SettingsSection(
                      title: S.of(context).preferences,
                      children: [
                        SettingsTile(
                          icon: Icons.interests_rounded,
                          title: S.of(context).customizeThemeAndLanguage,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LanguageAndThemePage(),
                              ),
                            );
                          },
                        ),
                        Divider(height: 1, color: colors.border),

                        NotificationTile(
                          value: notificationsEnabled,
                          onChanged: (value) {
                            setState(() => notificationsEnabled = value);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final l10n = S.of(context);
                  final confirmed = await profileDialog(
                    context,
                    l10n.signOut,
                    l10n.signOutDialogMessage,
                    l10n.confirm,
                    l10n.cancel,
                    Icons.logout_rounded,
                  );
                  if (!context.mounted) return;
                  if (confirmed != true) return;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: LoadingWidget()),
                  );

                  try {
                    await FirebaseAuth.instance.signOut();
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                      debugPrint('sign out failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.signOutFailed)),
                      );
                    }
                    return;
                  }

                  if (!context.mounted) return;
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OnBordingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: .15),
                  foregroundColor: colors.danger,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: Text(
                  S.of(context).signOut,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
