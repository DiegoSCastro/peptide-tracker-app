import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peptide_tracker_app/src/core/notifications/notification_gateway.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Notification gateway backed by flutter_local_notifications.
class FlutterLocalNotificationGateway implements NotificationGateway {
  /// Creates the gateway with a default plugin instance.
  FlutterLocalNotificationGateway()
    : _plugin = FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.UTC);

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
      macOS: DarwinInitializationSettings(),
    );

    await _plugin.initialize(initializationSettings);
    _initialized = true;
  }

  @override
  Future<bool> requestPermissions() async {
    await initialize();

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final androidAllowed = await android?.requestNotificationsPermission();

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final iosAllowed = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    final macos = _plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >();
    final macosAllowed = await macos?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    return androidAllowed ??
        iosAllowed ??
        macosAllowed ??
        defaultTargetPlatform.name.isNotEmpty;
  }

  @override
  Future<void> schedule(ScheduledNotification notification) async {
    await initialize();

    await _plugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(notification.scheduledAt.toUtc(), tz.UTC),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'routine-reminders',
          'Routine reminders',
          channelDescription: 'Local reminders for saved routines.',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: notification.payload,
    );
  }

  @override
  Future<void> cancel(int id) async {
    await initialize();
    await _plugin.cancel(id);
  }
}
