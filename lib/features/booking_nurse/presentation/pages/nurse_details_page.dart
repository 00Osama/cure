import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/booking_nurse/presentation/pages/book_appointment.dart';
import 'package:cure/features/booking_nurse/presentation/widgets/nurse_details_tile.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/available_nurse.dart';
import '../widgets/nurse_avatar.dart';

class NurseDetailsPage extends StatelessWidget {
  const NurseDetailsPage({super.key, required this.nurse, required this.role});

  final AvailableNurse nurse;
  final String role;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    String formatExperience(String years) {
      switch (years) {
        case 'lessThanOne':
          return S.of(context).lessThanOneExperience;
        case 'oneToThree':
          return S.of(context).oneToThreeExperience;
        case 'threeToFive':
          return S.of(context).threeToFiveExperience;
        case 'moreThanFive':
          return S.of(context).moreThanFiveExperience;
        default:
          return '$years years of experience';
      }
    }

    String formatRegion(String region) {
      switch (region) {
        case 'tamiya':
          return S.of(context).regionTamiya;
        case 'youssefElSeddik':
          return S.of(context).regionYoussefElSeddik;
        case 'itsa':
          return S.of(context).regionItsa;
        case 'fayoumCity':
          return S.of(context).regionFayoumCity;
        case 'other':
          return S.of(context).regionOther;
        default:
          return region;
      }
    }

    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).nurseDetails,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                NurseAvatar(imageUrl: nurse.profileImageUrl, radius: 64),
                const SizedBox(height: 12),
                Text(
                  nurse.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          NurseDetailsTile(
            label: S.of(context).phoneNumber,
            value: nurse.phoneNumber,
            phoneNumber: nurse.phoneNumber,
          ),
          NurseDetailsTile(
            label: S.of(context).age,
            value: '${nurse.age} ${S.of(context).yearsOld}',
          ),
          NurseDetailsTile(
            label: S.of(context).gender,
            value: nurse.gender == 'male'
                ? S.of(context).maleLabel
                : S.of(context).femaleLabel,
          ),
          NurseDetailsTile(
            label: S.of(context).region,
            value: formatRegion(nurse.region!),
          ),
          NurseDetailsTile(
            label: S.of(context).yearsOfExperience,
            value: formatExperience(nurse.yearOfExperience!),
          ),
          NurseDetailsTile(
            label: S.of(context).skillSet,
            value: nurse.skillSet,
          ),
          role == 'nurse'
              ? Container()
              : AppPrimaryButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointment(nurse: nurse),
                      ),
                    );
                  },
                  title: S().bookingDetails,
                ),
        ],
      ),
    );
  }
}
