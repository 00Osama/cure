import 'package:flutter/material.dart';

import 'package:cure/features/booking/domain/entities/booking.dart';
import 'package:cure/features/booking/domain/usecase/booking_usecase.dart';
import 'package:cure/features/booking/presentation/widgets/booking_list_item.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/utils/result.dart';
import 'package:cure/shared/widgets/gradient_scaffold.dart';
import 'package:cure/shared/widgets/loading_widget.dart';

/// Light, read-only list of incoming (`requested`) bookings for nurses.
/// Intentionally simple (FutureBuilder, no actions) per the patient-centric
/// scope.
class NurseIncomingPage extends StatefulWidget {
  const NurseIncomingPage({super.key, required this.useCase});

  final BookingUseCase useCase;

  @override
  State<NurseIncomingPage> createState() => _NurseIncomingPageState();
}

class _NurseIncomingPageState extends State<NurseIncomingPage> {
  late Future<Result<List<Booking>>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.useCase.getIncomingRequests();
  }

  Future<void> _refresh() async {
    setState(() => _future = widget.useCase.getIncomingRequests());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(s.incomingRequests),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<Result<List<Booking>>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            }
            final result = snapshot.data;
            if (result is Failure<List<Booking>>) {
              return _Message(text: result.error.toString());
            }
            final bookings = result is Success<List<Booking>>
                ? result.data
                : <Booking>[];
            if (bookings.isEmpty) {
              return _Message(text: s.noIncomingRequests);
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: bookings
                  .map((b) => BookingListItem(booking: b))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 120),
        Center(
          child: Text(text, style: const TextStyle(color: Colors.white60)),
        ),
      ],
    );
  }
}
