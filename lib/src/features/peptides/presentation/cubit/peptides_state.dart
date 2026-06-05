part of 'peptides_cubit.dart';

/// View status for the peptides screen.
enum PeptidesStatus {
  /// No work has started yet.
  initial,

  /// Content is currently loading.
  loading,

  /// Content loaded successfully.
  success,

  /// Content failed to load.
  failure,
}

/// State consumed by the peptides page.
class PeptidesState extends Equatable {
  /// Creates the peptide page state.
  const PeptidesState({
    this.status = PeptidesStatus.initial,
    this.peptides = const [],
    this.message = '',
  });

  /// Current screen status.
  final PeptidesStatus status;

  /// Loaded peptide cards.
  final List<Peptide> peptides;

  /// Error message shown on failures.
  final String message;

  /// Returns a copy with updated fields.
  PeptidesState copyWith({
    PeptidesStatus? status,
    List<Peptide>? peptides,
    String? message,
  }) {
    return PeptidesState(
      status: status ?? this.status,
      peptides: peptides ?? this.peptides,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, peptides, message];
}
