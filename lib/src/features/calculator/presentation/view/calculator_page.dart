import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/features/calculator/domain/reconstitution_math.dart';

/// Compliance-safe calculator screen driven entirely by manual input.
class CalculatorPage extends StatefulWidget {
  /// Creates the calculator page.
  const CalculatorPage({super.key});

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

  ReconstitutionMathResult? _result;

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

    return Scaffold(
      appBar: AppBar(title: const Text('User-input calculator')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                _ResultCard(result: _result!),
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

    setState(() => _result = null);
  }

  double _parseNumber(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    return double.parse(normalized);
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

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final ReconstitutionMathResult result;

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 12),
            const Text('Double-check your entries before using this result.'),
          ],
        ),
      ),
    );
  }

  String _format(double value) {
    final fixed = value.toStringAsFixed(4);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
