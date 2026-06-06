import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/features/calculator/domain/reconstitution_math.dart';

void main() {
  group('ReconstitutionMath', () {
    test('calculates concentration and volume from manual input values', () {
      const input = ReconstitutionMathInput(
        vialAmountMg: 10,
        dilutionVolumeMl: 2,
        desiredAmountMg: 0.25,
      );

      final result = ReconstitutionMath.calculate(input);

      expect(result.concentrationMgPerMl, 5);
      expect(result.volumeToDrawMl, 0.05);
    });

    test('supports decimal math without recommendation logic', () {
      const input = ReconstitutionMathInput(
        vialAmountMg: 7.5,
        dilutionVolumeMl: 3,
        desiredAmountMg: 0.3,
      );

      final result = ReconstitutionMath.calculate(input);

      expect(result.concentrationMgPerMl, 2.5);
      expect(result.volumeToDrawMl, closeTo(0.12, 0.000001));
    });
  });
}
