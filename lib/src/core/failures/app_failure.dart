import 'package:equatable/equatable.dart';

/// Base failure for app-level errors.
sealed class AppFailure extends Equatable implements Exception {
  /// Creates an app failure.
  const AppFailure(this.message);

  /// Human-readable error message.
  final String message;

  @override
  List<Object> get props => [message];
}

/// Returned when the local peptide catalog is empty.
final class EmptyCatalogFailure extends AppFailure {
  /// Creates the empty catalog failure.
  const EmptyCatalogFailure()
    : super('No peptides are available in the local catalog.');
}

/// Returned when local persistence fails.
final class StorageFailure extends AppFailure {
  /// Creates the storage failure.
  const StorageFailure([
    super.message = 'Unable to save local data right now.',
  ]);
}

/// Returned when the free tier protocol limit is reached.
final class ProtocolLimitReachedFailure extends AppFailure {
  /// Creates the protocol limit failure.
  const ProtocolLimitReachedFailure()
    : super('Free supports 1 active routine. Upgrade later for more.');
}
