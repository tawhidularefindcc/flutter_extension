import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/onboarding_controller.dart';
import 'package:flutter_extension/data/model/onboarding_item_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F8),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.skip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 40 / 2,
                          color: Color(0xFF7D7D7D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.onboardingItems.length,
                      onPageChanged: controller.onPageChanged,
                      itemBuilder: (context, index) {
                        return _OnboardingPage(
                          item: controller.onboardingItems[index],
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    onTap: controller.nextPage,
                    text:
                        controller.currentPage ==
                            controller.onboardingItems.length - 1
                        ? 'Get Started'
                        : 'Next',
                    suffixIcon:
                        controller.currentPage ==
                            controller.onboardingItems.length - 1
                        ? null
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                    radius: 14,
                    height: 56,
                    gradient: AppColors.primaryGradient,
                  ),
                  const SizedBox(height: 14),
                  _PageDots(
                    count: controller.onboardingItems.length,
                    currentIndex: controller.currentPage,
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingItemModel item;

  const _OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFD2D8E1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(item.icon, size: 66, color: const Color(0xFF101828)),
            ),
            const SizedBox(height: 34),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 49 / 2,
                height: 1.12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101118),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.25,
                color: Color(0xFF66779B),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE0E1E5)),
                color: const Color(0xFFF6F6F8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account benefits',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF15171D),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...item.benefits.map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Color(0xFF28C663),
                            size: 21,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(
                                fontSize: 36 / 2,
                                height: 1.2,
                                color: Color(0xFF617296),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _PageDots({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: isActive ? 16 : 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive ? const Color(0xFF208DB3) : const Color(0xFFCDCED2),
          ),
        );
      }),
    );
  }
}
