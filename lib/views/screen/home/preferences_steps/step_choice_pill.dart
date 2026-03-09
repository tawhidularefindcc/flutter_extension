import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

class StepChoicePill extends StatelessWidget {
  const StepChoicePill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.height = 32,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? AppColors.primaryGradient : null,
          color: selected ? null : const Color(0xFFE0E5EE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: selected ? Colors.white : const Color(0xFF6B7A97),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
