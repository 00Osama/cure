import 'dart:io';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/slide_header.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/utils/media_permission.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                      final permission =
                          await MediaPermission.requestGalleryAccess();
                      if (!context.mounted) return;
                      if (permission == MediaPermissionResult.denied) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).storagePermissionDenied,
                            ),
                          ),
                        );
                        return;
                      }
                      if (permission ==
                          MediaPermissionResult.permanentlyDenied) {
                        await MediaPermission.showOpenSettingsDialog(context);
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
}
