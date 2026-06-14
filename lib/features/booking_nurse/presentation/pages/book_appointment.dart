import 'package:cure/core/theme_and_locals/app_colors.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/booking_nurse/domain/entities/available_nurse.dart';
import 'package:cure/features/booking_nurse/presentation/widgets/booking_step.dart';
import 'package:cure/features/booking_nurse/presentation/widgets/service_category_card.dart';
import 'package:cure/generated/l10n.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key, required this.nurse});

  final AvailableNurse nurse;

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _clinicalNotesController =
      TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  String? _selectedService;
  DateTime? _selectedDate;
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _selectedDate = DateTime(today.year, today.month, today.day);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _clinicalNotesController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (!context.mounted || pickedDate == null) return;

    // Show time picker after date is picked
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (pickedTime == null) return;

    // Combine date and time
    final selectedDateTime = DateTime(
      pickedDate!.year,
      pickedDate!.month,
      pickedDate!.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDate = selectedDateTime;
      // Format date & time nicely
      _dateTimeController.text =
          "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year} "
          "${pickedTime.format(context)}";
    });
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
  }

  void _bookNow(BuildContext context) {
    final l10n = S.of(context);

    if (_selectedService == null) {
      _showError(context, l10n.bookingSelectServiceError);
      return;
    } else if (_addressController.text.trim().isEmpty) {
      _showError(context, l10n.bookingAddressRequiredError);
      return;
    } else if (_clinicalNotesController.text.trim().isEmpty) {
      _showError(context, l10n.bookingClinicalNotesRequiredError);
      return;
    } else if (_dateTimeController.text.trim().isEmpty) {
      _showError(context, l10n.bookingDateTimeRequiredError);
      return;
    } else {
      /// handle nurse booking here
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final List<ServiceCategory> categories = [
      ServiceCategory(
        title: l10n.basic_services,
        icon: '',
        services: [
          l10n.basic_services_list1,
          l10n.basic_services_list2,
          l10n.basic_services_list3,
          l10n.basic_services_list4,
          l10n.basic_services_list5,
          l10n.basic_services_list6,
          l10n.basic_services_list7,
          l10n.basic_services_list8,
          l10n.basic_services_list9,
        ],
      ),
      ServiceCategory(
        title: l10n.wound_care,
        icon: '',
        services: [
          l10n.wound_care_list1,
          l10n.wound_care_list2,
          l10n.wound_care_list3,
          l10n.wound_care_list4,
          l10n.wound_care_list5,
          l10n.wound_care_list6,
        ],
      ),
      ServiceCategory(
        title: l10n.elderly_care,
        icon: '',
        services: [
          l10n.elderly_care_list1,
          l10n.elderly_care_list2,
          l10n.elderly_care_list3,
          l10n.elderly_care_list4,
          l10n.elderly_care_list5,
          l10n.elderly_care_list6,
          l10n.elderly_care_list7,
        ],
      ),
      ServiceCategory(
        title: l10n.chronic_diseases,
        icon: '',
        services: [
          l10n.chronic_diseases_list1,
          l10n.chronic_diseases_list2,
          l10n.chronic_diseases_list3,
          l10n.chronic_diseases_list4,
          l10n.chronic_diseases_list5,
          l10n.chronic_diseases_list6,
        ],
      ),
      ServiceCategory(
        title: l10n.post_surgery,
        icon: '',
        services: [
          l10n.post_surgery_list1,
          l10n.post_surgery_list2,
          l10n.post_surgery_list3,
          l10n.post_surgery_list4,
          l10n.post_surgery_list5,
          l10n.post_surgery_list6,
        ],
      ),
      ServiceCategory(
        title: l10n.respiratory_care,
        icon: '',
        services: [
          l10n.respiratory_care_list1,
          l10n.respiratory_care_list2,
          l10n.respiratory_care_list3,
          l10n.respiratory_care_list4,
          l10n.respiratory_care_list5,
        ],
      ),
      ServiceCategory(
        title: l10n.catheter_care,
        icon: '',
        services: [
          l10n.catheter_care_list1,
          l10n.catheter_care_list2,
          l10n.catheter_care_list3,
          l10n.catheter_care_list4,
        ],
      ),
      ServiceCategory(
        title: l10n.psych_support,
        icon: '',
        services: [
          l10n.psych_support_list1,
          l10n.psych_support_list2,
          l10n.psych_support_list3,
          l10n.psych_support_list4,
          l10n.psych_support_list5,
        ],
      ),
      ServiceCategory(
        title: l10n.emergency_services,
        icon: '',
        services: [
          l10n.emergency_services_list1,
          l10n.emergency_services_list2,
          l10n.emergency_services_list3,
          l10n.emergency_services_list4,
        ],
      ),
    ];

    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.gradientEnd,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.bookAppointment,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          BookingStep(stepNumber: '1', stepText: l10n.StepOneChooseService),
          ...categories.map(
            (category) => ServiceCategoryCard(
              category: category,
              selectedService: _selectedService,
              onServiceSelected: (service) {
                setState(() => _selectedService = service);
              },
            ),
          ),
          BookingStep(stepNumber: '2', stepText: l10n.StepTwoPatientDetails),
          const SizedBox(height: 15),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _addressController,
                    minLines: 2,
                    maxLines: 3,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      labelText: l10n.addressLabel,
                      hintText: l10n.addressHint,
                      alignLabelWithHint: false,
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _clinicalNotesController,
                    minLines: 4,
                    maxLines: 6,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      labelText: l10n.clinicalRemarks,
                      hintText: l10n.remarksHint,
                      alignLabelWithHint: false,
                      prefixIcon: const Icon(
                        Icons.medical_information_outlined,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          BookingStep(
            stepNumber: '3',
            stepText: l10n.StepThreeChosseDateAndTime,
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _dateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: l10n.chooseDateTime,
                      hintText: l10n.chooseDateTime,
                      prefixIcon: const Icon(Icons.event_available_outlined),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onTap: () => _pickDate(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppPrimaryButton(
            onPressed: () => _bookNow(context),
            title: l10n.bookNow,
          ),
        ],
      ),
    );
  }
}
