import 'package:cure/core/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.imageProvider,
    required this.loading,
  });

  final ImageProvider? imageProvider;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (loading) {
      return Shimmer.fromColors(
        baseColor: colors.surfaceHigh,
        highlightColor: colors.surfacePressed,
        child: CircleAvatar(radius: 90, backgroundColor: colors.surface),
      );
    }

    return CircleAvatar(
      radius: 80,
      backgroundColor: colors.surfaceHigh,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Icon(Icons.person_rounded, size: 76, color: colors.onSurfaceSubtle)
          : null,
    );
  }
}
