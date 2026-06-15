import '../../../../core/network/api_client.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/entities/booking_status.dart';
import '../models/booking_model.dart';
import '../models/service_model.dart';

/// Remote data source over the dio [ApiClient]. All Supabase PostgREST query
/// syntax (`eq.`, `gte.`, `order`, ...) is isolated here so the rest of the
/// app stays backend-agnostic.
abstract class BookingRemoteDataSource {
  Future<List<ServiceModel>> getServices();
  Future<BookingModel> createBooking(Map<String, dynamic> insertBody);
  Future<List<BookingModel>> getMyBookings(String patientId);
  Future<BookingModel> updateStatus({
    required String bookingId,
    required BookingStatus status,
  });
  Future<List<BookingModel>> getIncomingRequests();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  BookingRemoteDataSourceImpl({required ApiClient apiClient})
    : _api = apiClient;

  final ApiClient _api;

  @override
  Future<List<ServiceModel>> getServices() async {
    final rows = await _api.getList(
      'services',
      query: {'active': 'eq.true', 'order': 'sort_order.asc'},
    );
    return rows
        .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BookingModel> createBooking(Map<String, dynamic> insertBody) async {
    final data = await _api.post('bookings', body: insertBody);
    final rows = data is List ? data : [data];
    if (rows.isEmpty) {
      throw const ServerFailure('Booking could not be created.');
    }
    return BookingModel.fromJson(rows.first as Map<String, dynamic>);
  }

  @override
  Future<List<BookingModel>> getMyBookings(String patientId) async {
    final rows = await _api.getList(
      'bookings',
      query: {
        'patient_id': 'eq.$patientId',
        'select': '*',
        'order': 'created_at.desc',
      },
    );
    return rows
        .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BookingModel> updateStatus({
    required String bookingId,
    required BookingStatus status,
  }) async {
    final data = await _api.patch(
      'bookings',
      body: {'status': statusToApi(status)},
      query: {'id': 'eq.$bookingId'},
    );
    final rows = data is List ? data : [data];
    if (rows.isEmpty) {
      throw const ServerFailure('Booking could not be updated.');
    }
    return BookingModel.fromJson(rows.first as Map<String, dynamic>);
  }

  @override
  Future<List<BookingModel>> getIncomingRequests() async {
    final rows = await _api.getList(
      'bookings',
      query: {'status': 'eq.requested', 'order': 'created_at.desc'},
    );
    return rows
        .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
