import 'dart:io';
import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/core/utils/media_permission.dart';
import 'package:cure/core/widgets/app_primary_button.dart';
import 'package:cure/features/auth/presentation/widgets/slide_header.dart';
import 'package:cure/generated/l10n.dart';
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
    final colors = AppColors.of(context);

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
                  radius: 80,
                  backgroundColor: colors.iconBackground,
                  backgroundImage: _hasImage
                      ? FileImage(File(imagePath))
                      : null,
                  child: !_hasImage
                      ? CircleAvatar(
                          radius: 80,
                          backgroundColor: colors.surfaceHigh,
                          child: Icon(
                            Icons.person_rounded,
                            size: 76,
                            color: colors.onSurfaceSubtle,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 13),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AppPrimaryButton(
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

                if (_hasImage) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: OutlinedButton.icon(
                      onPressed: () => onImagePicked('default'),
                      icon: const Icon(Icons.delete_outline),
                      label: Text(S().deletePhoto),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
