import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({
    super.key,
    required this.zone,
    required this.score,
  });

  final String zone;
  final int score;

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
        title: Text(
          zone,
          style: const TextStyle(
            color: AppColors.slate800,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.slate500.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.map_rounded,
                  size: 48,
                  color: AppColors.slate500,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Fit score: $score/100',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.slate800,
              ),
            ),
            const SizedBox(height: 10),
            const _MetricBar(
              label: 'Safety',
              value: 88,
              color: AppColors.green500,
            ),
            const _MetricBar(
              label: 'Schools',
              value: 85,
              color: AppColors.blue500,
            ),
            const _MetricBar(
              label: 'Transit',
              value: 78,
              color: AppColors.primaryTeal,
            ),
            const _MetricBar(
              label: 'Price',
              value: 62,
              color: AppColors.amber500,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricBar extends StatelessWidget {
  const _MetricBar({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
              Text('$value'),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 6,
              color: color,
              backgroundColor: AppColors.slate500.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}
