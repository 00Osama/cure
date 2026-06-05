import 'dart:io';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/slide_header.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
    required this.imagePath,
    required this.onImagePicked,
    required this.page,
  });

  final String imagePath;
  final String page;
  final ValueChanged<String> onImagePicked;

  bool get _hasImage {
    return imagePath.isNotEmpty &&
        imagePath != 'default' &&
        File(imagePath).existsSync();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: page == 'nurse' ? 20.0 : 0,
        vertical: page == 'nurse' ? 24.0 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideHeader(
            title: S.of(context).profilePhotoHeaderTitle,
            subtitle: S.of(context).profilePhotoHeaderSubtitle,
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  backgroundImage: _hasImage
                      ? FileImage(File(imagePath))
                      : null,
                  child: !_hasImage
                      ? const Icon(
                          Icons.camera_alt_outlined,
                          size: 56,
                          color: Colors.white70,
                        )
                      : null,
                ),
                const SizedBox(height: 13),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AppPrimaryButton(
                    color: const Color.fromARGB(255, 106, 182, 74),
                    title: S.of(context).SelectPhoto,
                    onPressed: () async {
                      await Permission.storage.request();
                      if (await Permission.storage.status.isDenied) {
                        await showStoragePermissionDialog(context);
                        return;
                      }
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        onImagePicked(pickedFile.path);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showStoragePermissionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.folder_off_rounded,
                    size: 36,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).storagePermissionDialogTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).storagePermissionDialogMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(S.of(context).storagePermissionDialogLater),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await openAppSettings();
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          S.of(context).storagePermissionDialogOpenSettings,
                        ),
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
}
