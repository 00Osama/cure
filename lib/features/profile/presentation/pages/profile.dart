import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure/features/auth/presentation/pages/onbording_page.dart';
import 'package:cure/features/profile/presentation/pages/edit_profile.dart';
import 'package:cure/features/profile/presentation/pages/theme_and_language.dart';
import 'package:cure/features/profile/presentation/widgets/notification_tile.dart';
import 'package:cure/features/profile/presentation/widgets/profile_title.dart';
import 'package:cure/features/profile/presentation/widgets/settings_section.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/models/app_colors.dart';
import 'package:cure/shared/theme_and_locals/locals_cubit.dart';
import 'package:cure/shared/theme_and_locals/them_cubit.dart';
import 'package:cure/shared/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  bool isDark = false;
  bool isArabic = false;

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
        return Dialog(
          backgroundColor: AppColors.card,
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
                    color: Colors.red.withValues(alpha: .15),
                  ),
                  child: Icon(icon, color: Colors.red, size: 34),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                        ),
                        child: Text(cancelText),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please login again to delete your account."),
          ),
        );
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('un expected error ocured')));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S().profile,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 12),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'id',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .limit(1)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: Text(
                        'Shimmer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return Shimmer.fromColors(
                  baseColor: Colors.red,
                  highlightColor: Colors.yellow,
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Account
            SettingsSection(
              title: S().account,
              children: [
                SettingsTile(
                  icon: Icons.edit_outlined,
                  title: S().editProfile,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfile()),
                    );
                  },
                ),
                const Divider(height: 1, color: Colors.white10),
                SettingsTile(
                  icon: Icons.delete_outline,
                  title: S().deleteAccount,
                  textColor: Colors.red,
                  onTap: () async {
                    final confirmed = await profileDialog(
                      context,
                      S().deleteAccount,
                      S().deleteAccountDialogMessage,
                      S().confirm,
                      S().cancel,
                      Icons.delete_outline,
                    );
                    if (confirmed != true) return;

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: LoadingWidget()),
                    );

                    final deleted = await deleteAccount(context);

                    if (!mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();

                    if (deleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          content: Text(
                            S().accountDeleted,
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
                      title: S().preferences,
                      children: [
                        SettingsTile(
                          icon: Icons.interests_rounded,
                          title: S().customizeThemeAndLanguage,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LanguageAndThemePage(),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, color: Colors.white10),

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
                  final confirmed = await profileDialog(
                    context,
                    S().signOut,
                    S().signOutDialogMessage,
                    S().confirm,
                    S().cancel,
                    Icons.logout_rounded,
                  );
                  if (confirmed != true) return;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: LoadingWidget()),
                  );

                  try {
                    await FirebaseAuth.instance.signOut();
                  } catch (e) {
                    if (mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign out failed: ${e.toString()}'),
                        ),
                      );
                    }
                    return;
                  }

                  if (!mounted) return;
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OnBordingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: .15),
                  foregroundColor: Colors.red,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: Text(
                  S().signOut,
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
