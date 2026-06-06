class ScheduledNotification {
  const ScheduledNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledAt,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final DateTime scheduledAt;
  final String? payload;
}

abstract interface class NotificationGateway {
  Future<void> initialize();

  Future<bool> requestPermissions();

  Future<void> schedule(ScheduledNotification notification);

  Future<void> cancel(int id);
}

class NoopNotificationGateway implements NotificationGateway {
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
