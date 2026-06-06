import 'package:flutter/widgets.dart';
import 'package:peptide_tracker_app/app/app.dart';
import 'package:peptide_tracker_app/src/core/notifications/flutter_local_notification_gateway.dart';

void main() {
  runApp(App(notificationGateway: FlutterLocalNotificationGateway()));
}
