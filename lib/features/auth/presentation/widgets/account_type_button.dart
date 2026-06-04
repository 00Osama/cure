import 'package:flutter/material.dart';

class AccountTypeButton extends StatefulWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const AccountTypeButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<AccountTypeButton> createState() => _AccountTypeButtonState();
}

class _AccountTypeButtonState extends State<AccountTypeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );

    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scale,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          splashColor: widget.color.withValues(alpha: 0.15),
          highlightColor: widget.color.withValues(alpha: 0.08),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

              // soft gradient background
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color.withValues(alpha: 0.12),
                  widget.color.withValues(alpha: 0.04),
                ],
              ),

              border: Border.all(
                color: widget.color.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // Icon section
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        widget.color.withValues(alpha: 0.25),
                        widget.color.withValues(alpha: 0.08),
                      ],
                    ),
                    border: Border.all(
                      color: widget.color.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.icon,
                      style: const TextStyle(fontSize: 34, height: 1),
                    ),
                  ),
                ),

                const SizedBox(width: 18),

                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'اضغط للمتابعة',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: widget.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
