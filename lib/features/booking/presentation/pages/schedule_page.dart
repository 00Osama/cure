import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cure/features/booking/domain/entities/availability_slot.dart';
import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/cubits/booking_state.dart';
import 'package:cure/features/booking/presentation/pages/remarks_address_page.dart';
import 'package:cure/features/booking/presentation/widgets/slot_tile.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/models/app_colors.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';
import 'package:cure/core/widgets/loading_widget.dart';

/// Step 2: pick a region + day, then a concrete availability slot.
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? _region;
  DateTime _day = DateTime.now();

  void _load() {
    final region = _region;
    if (region == null) return;
    context.read<BookingCubit>().loadAvailability(region: region, day: _day);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _day = picked);
      _load();
    }
  }

  void _selectSlot(AvailabilitySlot slot) {
    final cubit = context.read<BookingCubit>();
    cubit.selectSlot(slot);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const RemarksAddressPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = AppColors.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final regions = <String, String>{
      'fayoumCity': s.regionFayoumCity,
      'itsa': s.regionItsa,
      'tamiya': s.regionTamiya,
      'youssefElSeddik': s.regionYoussefElSeddik,
      'snores': s.regionSnores,
      'other': s.regionOther,
    };

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.chooseDateTime),
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _RegionSelector(
                label: s.selectRegion,
                value: _region,
                regions: regions,
                onChanged: (v) {
                  setState(() => _region = v);
                  _load();
                },
              ),
              const SizedBox(height: 12),
              Card(
                color: colors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Icon(Icons.event, color: colors.onSurfaceMuted),
                  title: Text(
                    DateFormat.yMMMMEEEEd(locale).format(_day),
                    style: TextStyle(color: colors.onSurface),
                  ),
                  trailing: TextButton(
                    onPressed: _pickDate,
                    child: Text(s.chooseDateTime),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                s.availableSlots,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: LoadingWidget()),
                )
              else if (_region == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    s.selectRegion,
                    style: TextStyle(color: colors.onSurfaceMuted),
                  ),
                )
              else if (state.slots.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    s.noSlots,
                    style: TextStyle(color: colors.onSurfaceMuted),
                  ),
                )
              else
                ...state.slots.map(
                  (slot) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SlotTile(
                      slot: slot,
                      selected: state.selectedSlot?.id == slot.id,
                      onTap: () => _selectSlot(slot),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RegionSelector extends StatelessWidget {
  const _RegionSelector({
    required this.label,
    required this.value,
    required this.regions,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final Map<String, String> regions;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final selectedText = value == null ? null : regions[value];

    return LayoutBuilder(
      builder: (context, constraints) {
        return PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          color: colors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 8,
          constraints: BoxConstraints.tightFor(width: constraints.maxWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors.border),
          ),
          onSelected: onChanged,
          itemBuilder: (context) {
            return regions.entries.map((entry) {
              final selected = entry.key == value;
              return PopupMenuItem<String>(
                value: entry.key,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check, color: colors.accent, size: 20),
                  ],
                ),
              );
            }).toList();
          },
          child: SizedBox(
            width: constraints.maxWidth,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: const Icon(Icons.location_on_outlined),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colors.onSurfaceMuted,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                selectedText ?? label,
                style: TextStyle(
                  color: selectedText == null
                      ? colors.onSurfaceSubtle
                      : colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
