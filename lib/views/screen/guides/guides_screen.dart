import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/gradient_header.dart';
import 'package:flutter_extension/views/screen/guides/guide_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          GradientHeader(
            subtitle: 'Knowledge base',
            title: 'Guides & Resources',
            bottom: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: AppColors.slate500,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Search guides...',
                      style: TextStyle(
                        color: AppColors.slate500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _buildGuideCategory(
                  Icons.home_outlined,
                  'Renting Process',
                  '3 guides',
                ),
                SizedBox(height: 12.h),
                _buildGuideCategory(
                  Icons.gavel_outlined,
                  'Legal Rights',
                  '2 guides',
                ),
                SizedBox(height: 12.h),
                _buildGuideCategory(
                  Icons.shield_outlined,
                  'Insurance',
                  '2 guides',
                ),
                SizedBox(height: 12.h),
                _buildGuideCategory(
                  Icons.credit_card_outlined,
                  'Financing',
                  '2 guides',
                ),
                SizedBox(height: 12.h),
                _buildGuideCategory(
                  Icons.compare_arrows_rounded,
                  'Credit Transfer',
                  '1 guide',
                ),
                SizedBox(height: 12.h),
                _buildGuideCategory(
                  Icons.checklist_rounded,
                  'Moving Checklist',
                  '2 guides',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCategory(IconData icon, String title, String subtitle) {
    return Builder(
      builder: (context) => InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GuideDetailScreen(
                title: title,
                summary:
                    '$title guide collection to help you take informed decisions.',
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColors.primarySky, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate800,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: AppColors.slate500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
