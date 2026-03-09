import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/fit_score_indicator.dart';
import 'package:flutter_extension/views/screen/results/result_compare_screen.dart';
import 'package:flutter_extension/views/screen/results/result_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

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
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              'Results — Lisbon',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.slate800,
              ),
            ),
            Text(
              '5 zones matched',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.slate500,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppColors.slate800),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.list_rounded, color: AppColors.slate800),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Placeholder
            Container(
              height: 250.h,
              width: double.infinity,
              color: AppColors.slate500.withValues(alpha: 0.1),
              child: Center(
                child: Icon(
                  Icons.map_rounded,
                  size: 48.sp,
                  color: AppColors.slate500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ZONE RANKINGS',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.slate500,
                          letterSpacing: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ResultCompareScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Compare',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildZoneCard(
                    rank: 1,
                    name: 'Belém',
                    location: 'West Lisbon',
                    score: 91,
                    isBestMatch: true,
                    metrics: {
                      'Safety': 88,
                      'Schools': 85,
                      'Transit': 78,
                      'Price': 82,
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildZoneCard(
                    rank: 2,
                    name: 'Parque das Nações',
                    location: 'East Lisbon',
                    score: 87,
                    metrics: {
                      'Safety': 90,
                      'Schools': 92,
                      'Transit': 95,
                      'Price': 58,
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneCard({
    required int rank,
    required String name,
    required String location,
    required int score,
    bool isBestMatch = false,
    required Map<String, int> metrics,
  }) {
    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [AppColors.shadow],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '#$rank $name',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.slate800,
                            ),
                          ),
                          if (isBestMatch) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green500.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'BEST MATCH',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14.sp,
                            color: AppColors.slate500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FitScoreIndicator(score: score, size: 50),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: metrics.entries.map((e) {
                return Column(
                  children: [
                    Text(
                      e.value.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: _getMetricColor(e.value),
                      ),
                    ),
                    Text(
                      e.key,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ResultDetailScreen(zone: name, score: score),
                        ),
                      );
                    },
                    text: 'View details',
                    height: 42.h,
                    radius: 8.r,
                    color: AppColors.primarySky,
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ResultCompareScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.compare_arrows_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.slate500.withValues(alpha: 0.1),
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.slate500.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getMetricColor(int value) {
    if (value >= 80) return AppColors.green500;
    if (value >= 60) return AppColors.amber500;
    return AppColors.red500;
  }
}
