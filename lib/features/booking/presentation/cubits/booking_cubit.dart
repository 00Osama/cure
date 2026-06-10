import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/result.dart';
import '../../domain/entities/availability_slot.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_status.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecase/booking_usecase.dart';
import 'booking_state.dart';

/// Drives the booking wizard: load services → pick service → resolve
/// availability → capture details → confirm. Every async path emits
/// loading → success/error explicitly.
class BookingCubit extends Cubit<BookingState> {
  BookingCubit({required this.useCase, required this.patientId})
    : super(const BookingState());

  final BookingUseCase useCase;
  final String patientId;

  Future<void> loadServices() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await useCase.getServices();
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(isLoading: false, services: data));
      case Failure(:final error):
        emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }

  void selectService(Service service) {
    emit(
      state.copyWith(
        selectedService: service,
        step: BookingStep.schedule,
        slots: const [],
        selectedSlot: null,
      ),
    );
  }

  Future<void> loadAvailability({
    required String region,
    required DateTime day,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, region: region));
    final result = await useCase.getAvailability(region: region, day: day);
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(isLoading: false, slots: data));
      case Failure(:final error):
        emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }

  void selectSlot(AvailabilitySlot slot) {
    emit(
      state.copyWith(
        selectedSlot: slot,
        scheduledAt: slot.startsAt,
        step: BookingStep.details,
      ),
    );
  }

  void setDetails({required String address, String? remarks}) {
    emit(
      state.copyWith(
        address: address,
        remarks: remarks,
        step: BookingStep.review,
      ),
    );
  }

  void goToStep(BookingStep step) => emit(state.copyWith(step: step));

  Future<void> confirmBooking() async {
    final service = state.selectedService;
    final scheduledAt = state.scheduledAt;
    final address = state.address;
    if (service == null || scheduledAt == null || address == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    final draft = Booking(
      id: '',
      patientId: patientId,
      nurseId: state.selectedSlot?.nurseId,
      serviceId: service.id,
      scheduledAt: scheduledAt,
      status: BookingStatus.requested,
      remarks: state.remarks,
      address: address,
      price: service.basePrice,
    );
    final result = await useCase.createBooking(draft);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            isLoading: false,
            confirmed: data,
            step: BookingStep.success,
          ),
        );
      case Failure(:final error):
        emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }
}
