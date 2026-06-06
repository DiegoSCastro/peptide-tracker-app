enum LogEntryStatus {
  done('done', 'Done'),
  skipped('skipped', 'Skipped');

  const LogEntryStatus(this.storageValue, this.label);

  final String storageValue;
  final String label;
}

LogEntryStatus logEntryStatusFromStorage(String value) {
  return LogEntryStatus.values.firstWhere(
    (status) => status.storageValue == value,
    orElse: () => LogEntryStatus.done,
  );
}
