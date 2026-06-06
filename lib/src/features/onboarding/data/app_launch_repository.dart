import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/onboarding/domain/protocol_draft.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Versioned identifier for the current medical/safety disclaimer copy.
const currentDisclaimerVersion = '2026-06-05';

const _acceptedDisclaimerVersionKey = 'legal.acceptedDisclaimerVersion';
const _acceptedAtKey = 'legal.acceptedAt';
const _notificationsPromptSeenKey = 'settings.notificationsPromptSeen';
const _firstProtocolKey = 'protocols.firstProtocol';

/// Snapshot of the local app launch state.
class LaunchSnapshot extends Equatable {
  /// Creates a launch snapshot.
  const LaunchSnapshot({
    this.acceptedDisclaimerVersion,
    this.acceptedAt,
    this.notificationsPromptSeen = false,
    this.firstProtocol,
  });

  /// Accepted disclaimer version, when present.
  final String? acceptedDisclaimerVersion;

  /// Acceptance timestamp, when present.
  final DateTime? acceptedAt;

  /// Whether the notification explainer has been seen.
  final bool notificationsPromptSeen;

  /// First saved protocol, when present.
  final ProtocolDraft? firstProtocol;

  /// Whether the disclaimer has been accepted for the current version.
  bool get hasAcceptedCurrentDisclaimer =>
      acceptedDisclaimerVersion == currentDisclaimerVersion;

  /// Whether onboarding should still be shown.
  bool get needsOnboarding =>
      !hasAcceptedCurrentDisclaimer || firstProtocol == null;

  /// Returns a copy with selective overrides.
  LaunchSnapshot copyWith({
    String? acceptedDisclaimerVersion,
    DateTime? acceptedAt,
    bool? notificationsPromptSeen,
    ProtocolDraft? firstProtocol,
  }) {
    return LaunchSnapshot(
      acceptedDisclaimerVersion:
          acceptedDisclaimerVersion ?? this.acceptedDisclaimerVersion,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      notificationsPromptSeen:
          notificationsPromptSeen ?? this.notificationsPromptSeen,
      firstProtocol: firstProtocol ?? this.firstProtocol,
    );
  }

  @override
  List<Object?> get props => [
    acceptedDisclaimerVersion,
    acceptedAt,
    notificationsPromptSeen,
    firstProtocol,
  ];
}

/// Repository for launch/onboarding state.
abstract interface class AppLaunchRepository {
  /// Loads the latest local launch state.
  Future<LaunchSnapshot> loadSnapshot();

  /// Records explicit disclaimer acceptance.
  Future<void> acceptDisclaimer({required String version});

  /// Records that the user saw the notification explainer.
  Future<void> markNotificationsPromptSeen();

  /// Persists the first protocol created in onboarding.
  Future<void> saveFirstProtocol(ProtocolDraft protocol);
}

/// Shared-preferences backed implementation used by the app.
class SharedPrefsAppLaunchRepository implements AppLaunchRepository {
  /// Creates the repository.
  const SharedPrefsAppLaunchRepository();

  @override
  Future<void> acceptDisclaimer({required String version}) async {
    final preferences = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();

    await preferences.setString(_acceptedDisclaimerVersionKey, version);
    await preferences.setString(_acceptedAtKey, now);
  }

  @override
  Future<LaunchSnapshot> loadSnapshot() async {
    final preferences = await SharedPreferences.getInstance();
    final protocolJson = preferences.getString(_firstProtocolKey);

    return LaunchSnapshot(
      acceptedDisclaimerVersion: preferences.getString(
        _acceptedDisclaimerVersionKey,
      ),
      acceptedAt: DateTime.tryParse(
        preferences.getString(_acceptedAtKey) ?? '',
      ),
      notificationsPromptSeen:
          preferences.getBool(_notificationsPromptSeenKey) ?? false,
      firstProtocol: protocolJson == null
          ? null
          : ProtocolDraft.fromJson(
              jsonDecode(protocolJson) as Map<String, dynamic>,
            ),
    );
  }

  @override
  Future<void> markNotificationsPromptSeen() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_notificationsPromptSeenKey, true);
  }

  @override
  Future<void> saveFirstProtocol(ProtocolDraft protocol) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_firstProtocolKey, protocol.encode());
  }
}
