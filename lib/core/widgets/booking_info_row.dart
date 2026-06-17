import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingInfoRow extends StatelessWidget {
  const BookingInfoRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  bool get _isPhoneNumber {
    final cleaned = text.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    return RegExp(r'^\d{7,15}$').hasMatch(cleaned);
  }

  Future<void> _callNumber() async {
    final uri = Uri(scheme: 'tel', path: text);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colors.surfaceHigh.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _isPhoneNumber ? _callNumber : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    text,
                    softWrap: true,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                if (_isPhoneNumber) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.call_rounded, size: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
