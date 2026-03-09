import 'package:flutter/material.dart';

class CommutePreferenceStep extends StatelessWidget {
  const CommutePreferenceStep({
    super.key,
    required this.selectedCommute,
    required this.onSelectCommute,
  });

  final String? selectedCommute;
  final ValueChanged<String> onSelectCommute;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TransportOption(
          title: 'Public transport',
          subtitle: 'Metro, bus, train',
          selected: selectedCommute == 'Public transport',
          onTap: () => onSelectCommute('Public transport'),
        ),
        const SizedBox(height: 10),
        _TransportOption(
          title: 'By car',
          subtitle: 'Parking & road access',
          selected: selectedCommute == 'By car',
          onTap: () => onSelectCommute('By car'),
        ),
        const SizedBox(height: 10),
        _TransportOption(
          title: 'Cycling / walking',
          subtitle: 'Bikeable & walkable zones',
          selected: selectedCommute == 'Cycling / walking',
          onTap: () => onSelectCommute('Cycling / walking'),
        ),
        const SizedBox(height: 10),
        _TransportOption(
          title: 'Mixed',
          subtitle: 'No strong preference',
          selected: selectedCommute == 'Mixed',
          onTap: () => onSelectCommute('Mixed'),
        ),
      ],
    );
  }
}

class _TransportOption extends StatelessWidget {
  const _TransportOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF1F5CA8) : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF1F5CA8)
                      : const Color(0xFFC3CAD6),
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1F5CA8),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21.5,
                      color: Color(0xFF11131A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF66779B),
                      fontWeight: FontWeight.w400,
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
