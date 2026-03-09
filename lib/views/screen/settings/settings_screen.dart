import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/screen/settings/legal_text_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slate800,
                ),
              ),
              Text(
                'Preferences & privacy',
                style: TextStyle(fontSize: 14.sp, color: AppColors.slate500),
              ),
              SizedBox(height: 20.h),
              _buildSectionCard([
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.primarySky.withValues(
                        alpha: 0.1,
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.slate500,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guest User',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.slate800,
                            ),
                          ),
                          Text(
                            'Data stored locally',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 92.w,
                      child: CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.signInScreen);
                        },
                        text: 'Sign in',
                        height: 36.h,
                        radius: 8.r,
                        color: AppColors.primarySky.withValues(alpha: 0.1),
                        textStyle: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primarySky,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Want to sync across devices?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                    Text(
                      'Create account >',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarySky,
                      ),
                    ),
                  ],
                ),
              ]),
              SizedBox(height: 24.h),
              _buildSectionTitle('APPEARANCE & LANGUAGE'),
              _buildSectionCard([
                _buildSettingItem(
                  Icons.language_rounded,
                  'Language',
                  trailing: _buildLanguageChip(),
                ),
                const Divider(),
                _buildSettingItem(
                  Icons.wb_sunny_outlined,
                  'Dark mode',
                  trailing: Switch(value: false, onChanged: (v) {}),
                ),
              ]),
              SizedBox(height: 24.h),
              _buildSectionTitle('NOTIFICATIONS'),
              _buildSectionCard([
                _buildSettingItem(
                  Icons.notifications_none_rounded,
                  'Push notifications',
                  trailing: Switch(value: false, onChanged: (v) {}),
                ),
              ]),
              SizedBox(height: 24.h),
              _buildSectionTitle('PRIVACY & DATA'),
              _buildSectionCard([
                _buildSettingItem(
                  Icons.shield_outlined,
                  'Privacy explanation',
                  trailing: _buildReadMore(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const LegalTextScreen(title: 'Privacy explanation'),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildSettingItem(
                  Icons.storage_rounded,
                  'Data source disclaimer',
                  trailing: _buildReadMore(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LegalTextScreen(
                          title: 'Data source disclaimer',
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildSettingItem(
                  Icons.lock_outline_rounded,
                  'Privacy Policy',
                  trailing: _buildReadMore(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const LegalTextScreen(title: 'Privacy Policy'),
                      ),
                    );
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.slate500,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title, {
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: AppColors.primarySky, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate800,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageChip() {
    return Row(
      children: [
        Text(
          '🇺🇸 English',
          style: TextStyle(fontSize: 12.sp, color: AppColors.slate800),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 12.sp,
          color: AppColors.slate500,
        ),
      ],
    );
  }

  Widget _buildReadMore() {
    return Row(
      children: [
        Text(
          'Read',
          style: TextStyle(fontSize: 12.sp, color: AppColors.slate500),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 12.sp,
          color: AppColors.slate500,
        ),
      ],
    );
  }
}
