/// Supported schedule types for a protocol.
enum ProtocolScheduleType {
  /// Reminders fire on selected weekdays.
  specificWeekdays,

  /// Reminders repeat every N days.
  everyNDays,

  /// No automatic reminders; logging is manual only.
  manualOnly,
}

/// Storage and display helpers for [ProtocolScheduleType].
extension ProtocolScheduleTypeX on ProtocolScheduleType {
  /// Value persisted in local storage.
  String get storageValue => switch (this) {
    ProtocolScheduleType.specificWeekdays => 'specific_weekdays',
    ProtocolScheduleType.everyNDays => 'every_n_days',
    ProtocolScheduleType.manualOnly => 'manual_only',
  };

  /// User-facing label for the schedule type.
  String get label => switch (this) {
    ProtocolScheduleType.specificWeekdays => 'Specific weekdays',
    ProtocolScheduleType.everyNDays => 'Every N days',
    ProtocolScheduleType.manualOnly => 'Manual only',
  };
}

/// Parses a stored schedule type value into [ProtocolScheduleType].
ProtocolScheduleType protocolScheduleTypeFromStorage(String value) {
  return ProtocolScheduleType.values.firstWhere(
    (scheduleType) => scheduleType.storageValue == value,
    orElse: () => ProtocolScheduleType.manualOnly,
  );
}
