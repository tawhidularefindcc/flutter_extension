import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:get/get.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F8),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6E0DF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Color(0xFF28B558),
                      size: 74,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Check your email',
                    style: TextStyle(
                      fontSize: 76 / 2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF11131A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We sent a reset link to ${controller.resetEmail}.\nCheck your inbox and follow the instructions.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 34 / 2,
                      color: Color(0xFF66779B),
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 44),
                  CustomButton(
                    onTap: controller.backToSignIn,
                    text: 'Back to Sign In',
                    radius: 12,
                    height: 56,
                    gradient: AppColors.primaryGradient,
                  ),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
