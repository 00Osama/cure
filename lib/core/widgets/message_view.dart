import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({
    super.key,
    required this.message,
    this.actionText,
    this.onPressed,
  });

  final String message;
  final String? actionText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceMuted, fontSize: 16),
            ),
            if (actionText != null && onPressed != null) ...[
              const SizedBox(height: 12),
              FilledButton(onPressed: onPressed, child: Text(actionText!)),
            ],
          ],
        ),
      ),
    );
  }
}
