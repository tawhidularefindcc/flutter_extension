import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitScoreIndicator extends StatelessWidget {
  final int score;
  final double size;

  const FitScoreIndicator({
    super.key,
    required this.score,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    Color scoreColor = _getScoreColor(score);
    
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: scoreColor, width: 2.w),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score.toString(),
              style: TextStyle(
                fontSize: (size / 3).sp,
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),
            Text(
              'Fit Score',
              style: TextStyle(
                fontSize: (size / 7).sp,
                color: AppColors.slate500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return AppColors.green500;
    if (score >= 75) return AppColors.blue500;
    if (score >= 60) return AppColors.amber500;
    return AppColors.red500;
  }
}
