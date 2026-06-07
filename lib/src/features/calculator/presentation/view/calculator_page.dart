import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/widgets/syringe_bar.dart';
import 'package:peptide_tracker_app/src/features/calculator/domain/reconstitution_math.dart';

/// Optional context used to pre-fill the calculator (e.g. from the Library).
class CalculatorPrefill {
  /// Creates a calculator prefill.
  const CalculatorPrefill({required this.compoundName, this.halfLife = ''});

  /// Compound name shown in the header.
  final String compoundName;

  /// Optional half-life string shown next to the name.
  final String halfLife;
}

/// Compliance-safe calculator screen driven entirely by manual input.
class CalculatorPage extends StatefulWidget {
  /// Creates the calculator page.
  const CalculatorPage({this.prefill, super.key});

  /// Optional pre-fill context (compound name / half-life).
  final CalculatorPrefill? prefill;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _vialAmountController = TextEditingController();
  final _dilutionVolumeController = TextEditingController();
  final _desiredAmountController = TextEditingController();
  final _vialAmountFocusNode = FocusNode();
  final _dilutionVolumeFocusNode = FocusNode();
  final _desiredAmountFocusNode = FocusNode();

  static const _syringeSizes = [0.3, 0.5, 1.0];

  ReconstitutionMathResult? _result;
  ReconstitutionMathResult? _preview;
  double _syringeSizeMl = 1;

  @override
  void initState() {
    super.initState();
    _vialAmountController.addListener(_updatePreview);
    _dilutionVolumeController.addListener(_updatePreview);
    _desiredAmountController.addListener(_updatePreview);
  }

  @override
  void dispose() {
    _vialAmountController.dispose();
    _dilutionVolumeController.dispose();
    _desiredAmountController.dispose();
    _vialAmountFocusNode.dispose();
    _dilutionVolumeFocusNode.dispose();
    _desiredAmountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prefill = widget.prefill;

    return Scaffold(
      appBar: AppBar(title: const Text('User-input calculator')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prefill != null) ...[
                _PrefillHeader(prefill: prefill),
                const SizedBox(height: 16),
              ],
              Text(
                'Simple calculator',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your own values to calculate a result.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              _DisclaimerCard(theme: theme),
              const SizedBox(height: 16),
              _InputCard(
                formKey: _formKey,
                vialAmountController: _vialAmountController,
                dilutionVolumeController: _dilutionVolumeController,
                desiredAmountController: _desiredAmountController,
                vialAmountFocusNode: _vialAmountFocusNode,
                dilutionVolumeFocusNode: _dilutionVolumeFocusNode,
                desiredAmountFocusNode: _desiredAmountFocusNode,
                onCalculate: _calculate,
                onReset: _reset,
              ),
              if (_result != null) ...[
                const SizedBox(height: 16),
                _ResultCard(
                  result: _result!,
                  syringeSizeMl: _syringeSizeMl,
                  syringeSizes: _syringeSizes,
                  onSyringeSizeChanged: (size) =>
                      setState(() => _syringeSizeMl = size),
                ),
              ] else if (_preview != null) ...[
                const SizedBox(height: 16),
                _PreviewCard(result: _preview!),
              ] else ...[
                const SizedBox(height: 16),
                const _EmptyStateCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _calculate() {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      setState(() => _result = null);
      return;
    }

    final input = ReconstitutionMathInput(
      vialAmountMg: _parseNumber(_vialAmountController.text),
      dilutionVolumeMl: _parseNumber(_dilutionVolumeController.text),
      desiredAmountMg: _parseNumber(_desiredAmountController.text),
    );

    setState(() {
      _result = ReconstitutionMath.calculate(input);
    });
  }

  void _reset() {
    _formKey.currentState?.reset();
    _vialAmountController.clear();
    _dilutionVolumeController.clear();
    _desiredAmountController.clear();

    setState(() {
      _result = null;
      _preview = null;
    });
  }

  /// Recomputes a live preview as the user types, without form validation.
  void _updatePreview() {
    final vial = _tryParse(_vialAmountController.text);
    final dilution = _tryParse(_dilutionVolumeController.text);
    final desired = _tryParse(_desiredAmountController.text);

    if (vial == null || dilution == null || desired == null) {
      if (_preview != null) setState(() => _preview = null);
      return;
    }
    if (vial <= 0 || dilution <= 0 || desired <= 0) {
      if (_preview != null) setState(() => _preview = null);
      return;
    }

    setState(() {
      _preview = ReconstitutionMath.calculate(
        ReconstitutionMathInput(
          vialAmountMg: vial,
          dilutionVolumeMl: dilution,
          desiredAmountMg: desired,
        ),
      );
    });
  }

  double _parseNumber(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    return double.parse(normalized);
  }

  double? _tryParse(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return null;
    return double.tryParse(normalized);
  }
}

class _DisclaimerCard extends StatelessWidget {
  const _DisclaimerCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informational calculations only',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('This tool performs math from the information you provide.'),
            SizedBox(height: 8),
            Text('For user-input math only. Not a dose recommendation.'),
            SizedBox(height: 8),
            Text(
              'This calculator only performs math using values you manually '
              'enter. It does not recommend what to take, how much to take, '
              'or when to take it.',
            ),
          ],
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.formKey,
    required this.vialAmountController,
    required this.dilutionVolumeController,
    required this.desiredAmountController,
    required this.vialAmountFocusNode,
    required this.dilutionVolumeFocusNode,
    required this.desiredAmountFocusNode,
    required this.onCalculate,
    required this.onReset,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController vialAmountController;
  final TextEditingController dilutionVolumeController;
  final TextEditingController desiredAmountController;
  final FocusNode vialAmountFocusNode;
  final FocusNode dilutionVolumeFocusNode;
  final FocusNode desiredAmountFocusNode;
  final VoidCallback onCalculate;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter values manually',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _CalculatorTextField(
                controller: vialAmountController,
                focusNode: vialAmountFocusNode,
                label: 'Vial amount',
                suffixText: 'mg',
                autofocus: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => dilutionVolumeFocusNode.requestFocus(),
              ),
              const SizedBox(height: 12),
              _CalculatorTextField(
                controller: dilutionVolumeController,
                focusNode: dilutionVolumeFocusNode,
                label: 'Dilution volume',
                suffixText: 'mL',
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => desiredAmountFocusNode.requestFocus(),
              ),
              const SizedBox(height: 12),
              _CalculatorTextField(
                controller: desiredAmountController,
                focusNode: desiredAmountFocusNode,
                label: 'Desired amount',
                suffixText: 'mg',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => onCalculate(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton(
                    onPressed: onCalculate,
                    child: const Text('Calculate'),
                  ),
                  OutlinedButton(
                    onPressed: onReset,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalculatorTextField extends StatelessWidget {
  const _CalculatorTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.suffixText,
    required this.textInputAction,
    this.autofocus = false,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String suffixText;
  final TextInputAction textInputAction;
  final bool autofocus;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        helperText: 'Required manual input',
        suffixText: suffixText,
      ),
      validator: (value) {
        final raw = value?.trim() ?? '';
        if (raw.isEmpty) {
          return 'Enter a value.';
        }

        final normalized = raw.replaceAll(',', '.');
        final parsed = double.tryParse(normalized);
        if (parsed == null) {
          return 'Enter a valid number.';
        }

        if (parsed <= 0) {
          return 'Enter a value greater than zero.';
        }

        return null;
      },
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No result yet',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              'Enter vial, dilution, and target values manually to see the '
              'result.',
            ),
          ],
        ),
      ),
    );
  }
}

class _PrefillHeader extends StatelessWidget {
  const _PrefillHeader({required this.prefill});

  final CalculatorPrefill prefill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.science_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prefill.compoundName,
                    style: theme.textTheme.titleMedium,
                  ),
                  if (prefill.halfLife.isNotEmpty)
                    Text(
                      'Half-life: ${prefill.halfLife}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.result});

  final ReconstitutionMathResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.visibility_outlined,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Live preview: ${_format(result.concentrationMgPerMl)} mg/mL · '
                '${_format(result.volumeToDrawMl)} mL per dose',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.result,
    required this.syringeSizeMl,
    required this.syringeSizes,
    required this.onSyringeSizeChanged,
  });

  final ReconstitutionMathResult result;
  final double syringeSizeMl;
  final List<double> syringeSizes;
  final ValueChanged<double> onSyringeSizeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Result', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(
              'Concentration: ${_format(result.concentrationMgPerMl)} mg/mL',
            ),
            const SizedBox(height: 8),
            Text(
              'Volume to draw: ${_format(result.volumeToDrawMl)} mL',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Syringe size', style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.xs),
            SegmentedButton<double>(
              segments: [
                for (final size in syringeSizes)
                  ButtonSegment<double>(
                    value: size,
                    label: Text('${_format(size)} mL'),
                  ),
              ],
              selected: {syringeSizeMl},
              showSelectedIcon: false,
              onSelectionChanged: (selection) =>
                  onSyringeSizeChanged(selection.first),
            ),
            const SizedBox(height: AppSpacing.md),
            SyringeBar(
              volumeMl: result.volumeToDrawMl,
              syringeSizeMl: syringeSizeMl,
            ),
            const SizedBox(height: 12),
            const Text('Double-check your entries before using this result.'),
          ],
        ),
      ),
    );
  }
}

String _format(double value) {
  final fixed = value.toStringAsFixed(4);
  return fixed
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}
