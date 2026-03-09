import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

class ResultCompareScreen extends StatelessWidget {
  const ResultCompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.slate800,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Compare Zones',
          style: TextStyle(
            color: AppColors.slate800,
            fontWeight: FontWeight.w700,
            fontSize: 19,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _CompareRow(label: 'Safety', left: '88', right: '90'),
          _CompareRow(label: 'Schools', left: '85', right: '92'),
          _CompareRow(label: 'Transit', left: '78', right: '95'),
          _CompareRow(label: 'Price', left: '82', right: '58'),
          _CompareRow(
            label: 'Overall',
            left: '91',
            right: '87',
            highlight: true,
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.label,
    required this.left,
    required this.right,
    this.highlight = false,
  });

  final String label;
  final String left;
  final String right;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primaryTeal.withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.slate500),
            ),
          ),
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
