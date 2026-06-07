import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level background message handler (FCM requires a top-level/static fn).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // The OS renders background messages in the tray automatically; this hook
  // exists so background isolate work could be added later.
  debugPrint('FCM background message: ${message.messageId}');
}

/// Wraps Firebase Cloud Messaging + local notifications behind one swappable,
/// testable surface (registered in DI). Handles permission, the FCM token,
/// foreground messages, and ad-hoc local notifications (used by the dashboard
/// to surface booking-status changes — see README "FCM").
class NotificationService {
  NotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _local = localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _local;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'cure_bookings',
    'Booking updates',
    description: 'Notifications about your booking status',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    await _messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _local.initialize(settings: initSettings);

    final android = _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(_channel);
    await android?.requestNotificationsPermission();

    // Render foreground messages (Android shows nothing by default).
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        showLocal(
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    });
  }

  /// Current device FCM token (stored on the user's profile for server pushes).
  Future<String?> token() => _messaging.getToken();

  Future<void> showLocal({required String title, required String body}) async {
    await _local.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}
