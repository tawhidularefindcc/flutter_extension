import 'package:flutter/material.dart';

import 'step_choice_pill.dart';

class BudgetStep extends StatelessWidget {
  const BudgetStep({
    super.key,
    required this.selectedBudget,
    required this.onSelectBudget,
  });

  final String selectedBudget;
  final ValueChanged<String> onSelectBudget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          _budgetDisplay(selectedBudget),
          style: const TextStyle(
            fontSize: 40,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Per month',
          style: TextStyle(
            fontSize: 18.5,
            color: Color(0xFF6A7997),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 26),
        Row(
          children: [
            Expanded(
              child: StepChoicePill(
                label: 'EUR500',
                selected: selectedBudget == 'EUR500',
                onTap: () => onSelectBudget('EUR500'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'EUR1k',
                selected: selectedBudget == 'EUR1k',
                onTap: () => onSelectBudget('EUR1k'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'EUR5k',
                selected: selectedBudget == 'EUR5k',
                onTap: () => onSelectBudget('EUR5k'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StepChoicePill(
                label: 'EUR2k',
                selected: selectedBudget == 'EUR2k',
                onTap: () => onSelectBudget('EUR2k'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'EUR8k',
                selected: selectedBudget == 'EUR8k',
                onTap: () => onSelectBudget('EUR8k'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StepChoicePill(
                label: 'EUR10k',
                selected: selectedBudget == 'EUR10k',
                onTap: () => onSelectBudget('EUR10k'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String budgetDisplay(String budget) {
  switch (budget) {
    case 'EUR500':
      return 'EUR 500';
    case 'EUR1k':
      return 'EUR 1,000';
    case 'EUR2k':
      return 'EUR 2,000';
    case 'EUR5k':
      return 'EUR 5,000';
    case 'EUR8k':
      return 'EUR 8,000';
    case 'EUR10k':
      return 'EUR 10,000';
    default:
      return 'EUR 5,000';
  }
}

String budgetSummary(String budget) {
  switch (budget) {
    case 'EUR500':
      return 'EUR500/month';
    case 'EUR1k':
      return 'EUR1,000/month';
    case 'EUR2k':
      return 'EUR2,000/month';
    case 'EUR5k':
      return 'EUR5,000/month';
    case 'EUR8k':
      return 'EUR8,000/month';
    case 'EUR10k':
      return 'EUR10,000/month';
    default:
      return 'EUR5,000/month';
  }
}

String _budgetDisplay(String budget) => budgetDisplay(budget);
