import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NurseAvatar extends StatelessWidget {
  const NurseAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 34,
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasImage = imageUrl.isNotEmpty && imageUrl != 'default';

    if (!hasImage) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: colors.surfaceHigh,
        child: Icon(
          Icons.person_rounded,
          color: colors.onSurfaceSubtle,
          size: radius,
        ),
      );
    }

    return ClipOval(
      child: Image.network(
        imageUrl,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Shimmer.fromColors(
            baseColor: colors.surfaceHigh,
            highlightColor: colors.surfacePressed,
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: colors.surfaceHigh,
            child: Icon(
              Icons.person_rounded,
              color: colors.onSurfaceSubtle,
              size: radius,
            ),
          );
        },
      ),
    );
  }
}
