import 'package:cure/core/models/app_colors.dart';
import 'package:flutter/material.dart';

class DirectionalChevron extends StatelessWidget {
  const DirectionalChevron({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Icon(
      isRtl ? Icons.chevron_left : Icons.chevron_right,
      color: color ?? AppColors.of(context).onSurfaceSubtle,
      size: size,
      textDirection: TextDirection.ltr,
    );
  }
}
