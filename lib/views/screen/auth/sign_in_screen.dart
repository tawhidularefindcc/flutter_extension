import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/views/base/auth_text_field.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F8),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 140),
                  const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 76 / 2,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF11131A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Access your saved zones & reports',
                      style: TextStyle(
                        fontSize: 34 / 2,
                        color: Color(0xFF66779B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 18 + 7 / 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF172844),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AuthTextField(
                    controller: controller.signInEmailController,
                    hintText: 'you@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18 + 7 / 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF172844),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToForgotPassword,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color(0xFF0A4EA0),
                            fontWeight: FontWeight.w700,
                            fontSize: 16 + 4 / 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    controller: controller.signInPasswordController,
                    hintText: '..........',
                    obscureText: controller.signInPasswordHidden,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleSignInPasswordVisibility,
                      icon: Icon(
                        controller.signInPasswordHidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF758299),
                      ),
                    ),
                  ),
                  const SizedBox(height: 44),
                  CustomButton(
                    onTap: controller.signIn,
                    text: 'Sign In',
                    radius: 12,
                    height: 56,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF1F5CA8), Color(0xFF24B2A9)],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFB4BECD),
                          thickness: 1.3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            color: const Color(
                              0xFF6E7E97,
                            ).withValues(alpha: 0.95),
                            fontSize: 18 + 1 / 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFB4BECD),
                          thickness: 1.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: controller.continueAsGuest,
                    text: 'Continue as Guest',
                    radius: 12,
                    height: 56,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF1F5CA8), Color(0xFF24B2A9)],
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
