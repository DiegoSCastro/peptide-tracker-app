/// Payload for a locally scheduled notification.
class ScheduledNotification {
  /// Creates a scheduled notification.
  const ScheduledNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledAt,
    this.payload,
  });

  /// Platform notification identifier.
  final int id;

  /// Notification title shown to the user.
  final String title;

  /// Notification body shown to the user.
  final String body;

  /// UTC time when the notification should fire.
  final DateTime scheduledAt;

  /// Optional payload passed back when the notification is opened.
  final String? payload;
}

/// Abstraction over the platform notification scheduler.
abstract interface class NotificationGateway {
  /// Initializes the notification plugin.
  Future<void> initialize();

  /// Requests notification permissions from the user.
  Future<bool> requestPermissions();

  /// Schedules a local notification.
  Future<void> schedule(ScheduledNotification notification);

  /// Cancels a previously scheduled notification.
  Future<void> cancel(int id);
}

/// No-op gateway used in tests and unsupported platforms.
class NoopNotificationGateway implements NotificationGateway {
  /// Creates a no-op notification gateway.
  const NoopNotificationGateway();

  @override
  Future<void> cancel(int id) async {}

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermissions() async => false;

  @override
  Future<void> schedule(ScheduledNotification notification) async {}
}
