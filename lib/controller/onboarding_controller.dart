import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/onboarding_item_model.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final List<OnboardingItemModel> onboardingItems = const [
    OnboardingItemModel(
      icon: Icons.lightbulb_outline,
      title: 'Tell us what matters to you',
      description:
          "Answer a few simple questions about your needs - budget, safety, schools, transport - and we'll build your perfect neighbourhood profile.-",
      benefits: [
        'No personal info required',
        'Takes under 2 minutes',
        'Fully anonymous by default',
      ],
    ),
    OnboardingItemModel(
      icon: Icons.bar_chart_outlined,
      title: 'We analyse official data',
      description:
          'Our engine processes macro-level territorial data from official sources - crime statistics, school density, transport scores, and more.',
      benefits: [
        'National statistics offices',
        'Local government data',
        'Updated quarterly',
      ],
    ),
    OnboardingItemModel(
      icon: Icons.check_circle_outline,
      title: 'Get ranked recommendations',
      description:
          'Each area gets a personalised Fit Score based on your priorities. Compare zones side by side and explore detailed breakdowns.',
      benefits: [
        'Fit score from 0-100',
        'Side-by-side comparison',
        'Exportable reports',
      ],
    ),
    OnboardingItemModel(
      icon: Icons.lock_outline,
      title: 'Your privacy, always protected',
      description:
          'We never sell your data. Guest mode keeps everything local. Create an account if you want to sync across devices.',
      benefits: [
        'No tracking without consent',
        'Guest mode - no account needed',
        'GDPR compliant',
      ],
    ),
  ];

  void onPageChanged(int index) {
    _currentPage = index;
    update();
  }

  Future<void> nextPage() async {
    final int lastPage = onboardingItems.length - 1;
    if (_currentPage >= lastPage) {
      Get.offNamed(AppRoutes.homeScreen);
      return;
    }

    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    Get.offNamed(AppRoutes.homeScreen);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
