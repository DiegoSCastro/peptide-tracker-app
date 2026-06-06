import 'package:equatable/equatable.dart';

/// User-entered inputs for the neutral calculator.
class ReconstitutionMathInput extends Equatable {
  /// Creates a set of manual calculator inputs.
  const ReconstitutionMathInput({
    required this.vialAmountMg,
    required this.dilutionVolumeMl,
    required this.desiredAmountMg,
  });

  /// Total amount in the vial, in milligrams.
  final double vialAmountMg;

  /// Total dilution volume, in milliliters.
  final double dilutionVolumeMl;

  /// Target amount to convert into a volume, in milligrams.
  final double desiredAmountMg;

  @override
  List<Object> get props => [vialAmountMg, dilutionVolumeMl, desiredAmountMg];
}

/// Result of a neutral user-input calculation.
class ReconstitutionMathResult extends Equatable {
  /// Creates the calculated result.
  const ReconstitutionMathResult({
    required this.concentrationMgPerMl,
    required this.volumeToDrawMl,
  });

  /// Concentration derived from the user's values.
  final double concentrationMgPerMl;

  /// Volume equivalent for the desired amount.
  final double volumeToDrawMl;

  @override
  List<Object> get props => [concentrationMgPerMl, volumeToDrawMl];
}

/// Pure math for the compliance-safe calculator.
final class ReconstitutionMath {
  const ReconstitutionMath._();

  /// Calculates concentration and volume from user-entered values only.
  static ReconstitutionMathResult calculate(ReconstitutionMathInput input) {
    final concentrationMgPerMl = input.vialAmountMg / input.dilutionVolumeMl;
    final volumeToDrawMl = input.desiredAmountMg / concentrationMgPerMl;

    return ReconstitutionMathResult(
      concentrationMgPerMl: concentrationMgPerMl,
      volumeToDrawMl: volumeToDrawMl,
    );
  }
}
