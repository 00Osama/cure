import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cure/features/booking/presentation/cubits/booking_cubit.dart';
import 'package:cure/features/booking/presentation/pages/review_confirm_page.dart';
import 'package:cure/features/auth/presentation/widgets/button.dart';
import 'package:cure/features/auth/presentation/widgets/text_field.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/core/widgets/gradient_scaffold.dart';

/// Step 3: capture the visit address (required) and optional clinical remarks.
class RemarksAddressPage extends StatefulWidget {
  const RemarksAddressPage({super.key});

  @override
  State<RemarksAddressPage> createState() => _RemarksAddressPageState();
}

class _RemarksAddressPageState extends State<RemarksAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _remarks = TextEditingController();

  @override
  void dispose() {
    _address.dispose();
    _remarks.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<BookingCubit>();
    cubit.setDetails(
      address: _address.text.trim(),
      remarks: _remarks.text.trim(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const ReviewConfirmPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.clinicalRemarks),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            MyTextField(
              controller: _address,
              label: s.addressLabel,
              icon: Icons.home_outlined,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? s.errorRequired : null,
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: _remarks,
              label: s.clinicalRemarks,
              icon: Icons.notes_outlined,
              maxLines: 4,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 28),
            AppPrimaryButton(title: s.continueLabel, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
