import 'package:flutter/material.dart';

import 'budget_step.dart';
import 'step_choice_pill.dart';

class AreaVibeStep extends StatelessWidget {
  const AreaVibeStep({
    super.key,
    required this.showSummary,
    required this.selectedVibe,
    required this.onSelectVibe,
    this.selectedCountry,
    this.selectedCity,
    this.selectedBudget,
    this.selectedSafetyPriority,
    this.selectedSchoolPriority,
    this.selectedTransportPriority,
    this.selectedCommutePreference,
  });

  final bool showSummary;
  final String? selectedVibe;
  final ValueChanged<String> onSelectVibe;
  final String? selectedCountry;
  final String? selectedCity;
  final String? selectedBudget;
  final String? selectedSafetyPriority;
  final String? selectedSchoolPriority;
  final String? selectedTransportPriority;
  final String? selectedCommutePreference;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StepChoicePill(
                label: 'Quiet',
                selected: selectedVibe == 'Quiet',
                onTap: () => onSelectVibe('Quiet'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'Balance',
                selected: selectedVibe == 'Balance',
                onTap: () => onSelectVibe('Balance'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'Lively',
                selected: selectedVibe == 'Lively',
                onTap: () => onSelectVibe('Lively'),
              ),
            ),
          ],
        ),
        if (showSummary) ...[
          const SizedBox(height: 48),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 12, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E5EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your profile summary',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF11131A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _SummaryRow(
                  label: 'Country',
                  value: selectedCountry ?? 'Portugal',
                ),
                const SizedBox(height: 5),
                _SummaryRow(label: 'City', value: selectedCity ?? 'Porto'),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Budget',
                  value: budgetSummary(selectedBudget ?? 'EUR5k'),
                ),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Safety',
                  value: selectedSafetyPriority ?? 'Important',
                ),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Schools',
                  value: selectedSchoolPriority ?? 'Important',
                ),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Transport',
                  value: selectedTransportPriority ?? 'Somewhat',
                ),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Commute',
                  value: selectedCommutePreference ?? 'Not selected',
                ),
                const SizedBox(height: 5),
                _SummaryRow(
                  label: 'Vibe',
                  value: selectedVibe ?? 'Not selected',
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18.5,
              color: Color(0xFF66779B),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            color: Color(0xFF11131A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
