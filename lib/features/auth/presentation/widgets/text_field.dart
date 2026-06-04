import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType,
    this.readOnly = false,
    this.obscureText = false,
    this.onToggle,
    this.validator,
    this.onTap,
    this.textInputAction,
    this.suffixIcon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;

  final IconData? icon;
  final IconData? suffixIcon;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool readOnly;
  final bool obscureText;

  final int maxLines;

  final VoidCallback? onToggle;
  final VoidCallback? onTap;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: icon != null ? Icon(icon) : null,

        suffixIcon: onToggle != null
            ? IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : suffixIcon != null
            ? Icon(suffixIcon)
            : null,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.8),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.8),
        ),
      ),
    );
  }
}
