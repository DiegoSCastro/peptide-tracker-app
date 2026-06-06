import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/database/app_database.dart';
import 'package:peptide_tracker_app/src/core/design/app_theme.dart';
import 'package:peptide_tracker_app/src/core/notifications/notification_gateway.dart';
import 'package:peptide_tracker_app/src/core/notifications/protocol_reminder_scheduler.dart';
import 'package:peptide_tracker_app/src/features/history/data/repositories/drift_log_entries_repository.dart';
import 'package:peptide_tracker_app/src/features/history/domain/repositories/log_entries_repository.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';
import 'package:peptide_tracker_app/src/features/onboarding/presentation/view/onboarding_flow.dart';
import 'package:peptide_tracker_app/src/features/protocols/data/repositories/drift_protocols_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';
import 'package:peptide_tracker_app/src/features/settings/data/appearance_preferences.dart';
import 'package:peptide_tracker_app/src/features/shell/presentation/view/app_shell.dart';

/// Root application widget.
class App extends StatefulWidget {
  /// Creates the application shell.
  const App({
    super.key,
    this.database,
    this.launchRepository,
    this.protocolsRepository,
    this.logEntriesRepository,
    this.notificationGateway = const NoopNotificationGateway(),
    DateTime Function()? now,
  }) : now = now ?? DateTime.now;

  /// Optional database override used by tests.
  final AppDatabase? database;

  /// Optional launch repository override used by tests.
  final AppLaunchRepository? launchRepository;

  /// Optional protocols repository override used by tests.
  final ProtocolsRepository? protocolsRepository;

  /// Optional log entries repository override used by tests.
  final LogEntriesRepository? logEntriesRepository;

  /// Optional notification gateway override used by tests.
  final NotificationGateway notificationGateway;

  /// Optional now function override used by tests.
  final DateTime Function() now;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppDatabase _database = widget.database ?? AppDatabase();
  late final AppLaunchRepository _launchRepository =
      widget.launchRepository ?? const SharedPrefsAppLaunchRepository();
  late final ProtocolsRepository _protocolsRepository =
      widget.protocolsRepository ??
      DriftProtocolsRepository(database: _database);
  late final LogEntriesRepository _logEntriesRepository =
      widget.logEntriesRepository ??
      DriftLogEntriesRepository(database: _database);
  late final ProtocolReminderScheduler _reminderScheduler =
      ProtocolReminderScheduler(gateway: widget.notificationGateway);

  static const AppearancePreferences _appearancePreferences =
      AppearancePreferences();

  StreamSubscription<List<ManagedProtocol>>? _protocolSubscription;
  late Future<_BootstrapState> _bootstrapFuture = _loadBootstrapState();
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _protocolSubscription = _protocolsRepository.watchAll().listen(
      (items) => unawaited(
        _reminderScheduler.syncProtocols(
          items.map((item) => item.protocol),
          now: widget.now(),
        ),
      ),
    );
    unawaited(widget.notificationGateway.initialize());
    unawaited(_loadThemeMode());
  }

  Future<void> _loadThemeMode() async {
    final mode = await _appearancePreferences.load();
    if (!mounted) {
      return;
    }
    setState(() => _themeMode = mode);
  }

  void _updateThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
    unawaited(_appearancePreferences.save(mode));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peptide Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: FutureBuilder<_BootstrapState>(
        future: _bootstrapFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final bootstrapState = snapshot.data!;
          if (bootstrapState.needsOnboarding) {
            return OnboardingFlow(
              hasExistingProtocols: bootstrapState.protocolCount > 0,
              launchRepository: _launchRepository,
              protocolsRepository: _protocolsRepository,
              requestNotificationPermissions: _requestNotificationPermissions,
              onCompleted: _refreshBootstrapState,
            );
          }

          return AppShell(
            launchSnapshot: bootstrapState.launchSnapshot,
            logEntriesRepository: _logEntriesRepository,
            protocolsRepository: _protocolsRepository,
            now: widget.now,
            themeMode: _themeMode,
            onThemeModeChanged: _updateThemeMode,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _protocolSubscription?.cancel();
    if (widget.database == null) {
      unawaited(_database.close());
    }
    super.dispose();
  }

  Future<_BootstrapState> _loadBootstrapState() async {
    final launchSnapshot = await _launchRepository.loadSnapshot();
    final protocolCount = (await _protocolsRepository.watchAll().first).length;
    final needsOnboarding =
        !launchSnapshot.hasAcceptedCurrentDisclaimer || protocolCount == 0;

    return _BootstrapState(
      launchSnapshot: launchSnapshot,
      protocolCount: protocolCount,
      needsOnboarding: needsOnboarding,
    );
  }

  Future<void> _refreshBootstrapState() async {
    setState(() {
      _bootstrapFuture = _loadBootstrapState();
    });
  }

  Future<void> _requestNotificationPermissions() async {
    await widget.notificationGateway.requestPermissions();
  }
}

class _BootstrapState {
  const _BootstrapState({
    required this.launchSnapshot,
    required this.protocolCount,
    required this.needsOnboarding,
  });

  final LaunchSnapshot launchSnapshot;
  final int protocolCount;
  final bool needsOnboarding;
}
