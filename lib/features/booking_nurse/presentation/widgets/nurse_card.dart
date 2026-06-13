import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/available_nurse.dart';
import 'nurse_avatar.dart';

class NurseCard extends StatelessWidget {
  const NurseCard({super.key, required this.nurse, required this.onTap});

  final AvailableNurse nurse;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    String formatRegion(String region) {
      switch (region) {
        case 'tamiya':
          return S.of(context).regionTamiya;
        case 'youssefElSeddik':
          return S.of(context).regionYoussefElSeddik;
        case 'itsa':
          return S.of(context).regionItsa;
        case 'other':
          return S.of(context).regionOther;
        case 'snors':
          return S.of(context).regionSnores;
        case 'fayoumCity':
          return S.of(context).regionFayoumCity;
        default:
          return region;
      }
    }

    return Card(
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              NurseAvatar(imageUrl: nurse.profileImageUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nurse.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _InfoLine(
                      icon: Icons.phone_rounded,
                      text: nurse.phoneNumber!,
                    ),
                    const SizedBox(height: 4),
                    _InfoLine(
                      icon: Icons.cake_rounded,
                      text: '${nurse.age} ${S.of(context).yearsOld}',
                    ),
                    const SizedBox(height: 4),
                    _InfoLine(
                      icon: Icons.home_rounded,
                      text: formatRegion(nurse.region!),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceSubtle),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      children: [
        Icon(icon, size: 16, color: colors.onSurfaceSubtle),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: colors.onSurfaceMuted, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
