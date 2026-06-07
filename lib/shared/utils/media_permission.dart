import 'dart:io';

import 'package:cure/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum MediaPermissionResult { granted, denied, permanentlyDenied }

class MediaPermission {
  const MediaPermission._();

  static Future<MediaPermissionResult> requestGalleryAccess() async {
    if (kIsWeb) return MediaPermissionResult.granted;

    if (Platform.isIOS || Platform.isMacOS) {
      return _request(Permission.photos);
    }

    if (Platform.isAndroid) {
      final photos = await _request(Permission.photos);
      if (photos == MediaPermissionResult.granted ||
          photos == MediaPermissionResult.permanentlyDenied) {
        return photos;
      }
      return _request(Permission.storage);
    }

    return MediaPermissionResult.granted;
  }

  static Future<void> showOpenSettingsDialog(BuildContext context) async {
    final s = S.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s.storagePermissionDialogTitle),
          content: Text(s.storagePermissionDialogMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.storagePermissionDialogLater),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: Text(s.storagePermissionDialogOpenSettings),
            ),
          ],
        );
      },
    );
  }

  static Future<MediaPermissionResult> _request(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted || status.isLimited) {
      return MediaPermissionResult.granted;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return MediaPermissionResult.permanentlyDenied;
    }

    status = await permission.request();
    if (status.isGranted || status.isLimited) {
      return MediaPermissionResult.granted;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return MediaPermissionResult.permanentlyDenied;
    }
    return MediaPermissionResult.denied;
  }
}
