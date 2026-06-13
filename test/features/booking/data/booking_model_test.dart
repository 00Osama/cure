import 'package:cure/features/booking_nurse/data/models/booking_model.dart';
import 'package:cure/features/booking_nurse/domain/entities/booking_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromJson maps snake_case columns + embedded service key', () {
    final json = {
      'id': 'b1',
      'patient_id': 'p1',
      'nurse_id': 'n1',
      'service_id': 's1',
      'services': {'key': 'basicCare'},
      'scheduled_at': '2026-01-01T10:00:00Z',
      'status': 'confirmed',
      'remarks': 'note',
      'address': 'addr',
      'price': 50,
      'created_at': '2026-01-01T09:00:00Z',
    };

    final entity = BookingModel.fromJson(json).toEntity();

    expect(entity.id, 'b1');
    expect(entity.patientId, 'p1');
    expect(entity.nurseId, 'n1');
    expect(entity.serviceKey, 'basicCare');
    expect(entity.status, BookingStatus.confirmed);
    expect(entity.price, 50.0);
    expect(entity.remarks, 'note');
  });

  test('price parses when returned as a string by PostgREST', () {
    final model = BookingModel.fromJson({
      'id': 'b',
      'patient_id': 'p',
      'service_id': 's',
      'scheduled_at': '2026-01-01T10:00:00Z',
      'status': 'requested',
      'address': 'a',
      'price': '75.5',
    });
    expect(model.price, 75.5);
  });

  test('toInsertJson omits server-managed columns and null nurse', () {
    final body = BookingModel.toInsertJson(
      patientId: 'p',
      serviceId: 's',
      scheduledAt: DateTime.utc(2026, 1, 1, 10),
      address: 'a',
      price: 50,
    );

    expect(body.containsKey('id'), isFalse);
    expect(body.containsKey('created_at'), isFalse);
    expect(body.containsKey('nurse_id'), isFalse);
    expect(body['status'], 'requested');
    expect(body['patient_id'], 'p');
    expect(body['price'], 50);
  });
}
