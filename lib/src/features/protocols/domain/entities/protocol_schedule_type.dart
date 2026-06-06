enum ProtocolScheduleType { specificWeekdays, everyNDays, manualOnly }

extension ProtocolScheduleTypeX on ProtocolScheduleType {
  String get storageValue => switch (this) {
    ProtocolScheduleType.specificWeekdays => 'specific_weekdays',
    ProtocolScheduleType.everyNDays => 'every_n_days',
    ProtocolScheduleType.manualOnly => 'manual_only',
  };

  String get label => switch (this) {
    ProtocolScheduleType.specificWeekdays => 'Specific weekdays',
    ProtocolScheduleType.everyNDays => 'Every N days',
    ProtocolScheduleType.manualOnly => 'Manual only',
  };
}

ProtocolScheduleType protocolScheduleTypeFromStorage(String value) {
  return ProtocolScheduleType.values.firstWhere(
    (scheduleType) => scheduleType.storageValue == value,
    orElse: () => ProtocolScheduleType.manualOnly,
  );
}
