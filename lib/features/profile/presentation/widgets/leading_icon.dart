import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  final IconData icon;

  const LeadingIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
