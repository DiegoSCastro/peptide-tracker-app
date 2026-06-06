/// Completion status for a dose log entry.
enum LogEntryStatus {
  /// The dose was taken.
  done('done', 'Done'),

  /// The dose was intentionally skipped.
  skipped('skipped', 'Skipped');

  /// Creates a log entry status with storage and display labels.
  const LogEntryStatus(this.storageValue, this.label);

  /// Value persisted in local storage.
  final String storageValue;

  /// User-facing label for the status.
  final String label;
}

/// Parses a stored status value into [LogEntryStatus].
LogEntryStatus logEntryStatusFromStorage(String value) {
  return LogEntryStatus.values.firstWhere(
    (status) => status.storageValue == value,
    orElse: () => LogEntryStatus.done,
  );
}
