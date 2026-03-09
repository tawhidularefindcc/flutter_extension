import 'package:flutter/material.dart';

import 'step_choice_pill.dart';

class SchoolsEducationStep extends StatelessWidget {
  const SchoolsEducationStep({
    super.key,
    required this.selectedPriority,
    required this.onSelectPriority,
  });

  final String selectedPriority;
  final ValueChanged<String> onSelectPriority;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double chipWidth = (constraints.maxWidth - 24) / 3;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: chipWidth,
                      child: StepChoicePill(
                        label: 'Not',
                        selected: selectedPriority == 'Not',
                        onTap: () => onSelectPriority('Not'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: chipWidth,
                      child: StepChoicePill(
                        label: 'Somewhat',
                        selected: selectedPriority == 'Somewhat',
                        onTap: () => onSelectPriority('Somewhat'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: chipWidth,
                      child: StepChoicePill(
                        label: 'Important',
                        selected: selectedPriority == 'Important',
                        onTap: () => onSelectPriority('Important'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: chipWidth,
                  child: StepChoicePill(
                    label: 'Essential',
                    selected: selectedPriority == 'Essential',
                    onTap: () => onSelectPriority('Essential'),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 36),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E5EE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Includes',
                style: TextStyle(
                  fontSize: 21.5,
                  color: Color(0xFF11131A),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Primary & secondary school density, public/private\nratio, PISA scores by district',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.25,
                  color: Color(0xFF66779B),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
