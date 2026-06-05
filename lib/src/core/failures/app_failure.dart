import 'package:equatable/equatable.dart';

/// Base failure for app-level errors.
sealed class AppFailure extends Equatable {
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
