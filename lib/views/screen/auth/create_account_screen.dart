import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/views/base/auth_text_field.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
                  const SizedBox(height: 72),
                  const Center(
                    child: Text(
                      'Create Account',
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
                      'Free - always optional',
                      style: TextStyle(
                        fontSize: 34 / 2,
                        color: Color(0xFF66779B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE1E3E8)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account benefits',
                          style: TextStyle(
                            fontSize: 36 / 2,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF15171D),
                          ),
                        ),
                        SizedBox(height: 12),
                        _BenefitLine(text: 'Saved search history'),
                        SizedBox(height: 8),
                        _BenefitLine(text: 'Export personalised reports'),
                        SizedBox(height: 8),
                        _BenefitLine(text: 'Sync saved zones across devices'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 18 + 7 / 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF172844),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    controller: controller.fullNameController,
                    hintText: 'Your name',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Email',
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
                    controller: controller.createEmailController,
                    hintText: 'you@email.com',
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: Color(0xFF758299),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 18 + 7 / 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF172844),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    controller: controller.createPasswordController,
                    hintText: 'Min. 8 characters',
                    obscureText: controller.createPasswordHidden,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleCreatePasswordVisibility,
                      icon: Icon(
                        controller.createPasswordHidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF758299),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    onTap: controller.createAccount,
                    text: 'Create New Account',
                    radius: 12,
                    height: 56,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF1F5CA8), Color(0xFF24B2A9)],
                    ),
                  ),
                  const SizedBox(height: 42),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Skip for now - ',
                        style: const TextStyle(
                          fontSize: 38 / 2,
                          color: Color(0xFF172844),
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: controller.continueAsGuest,
                              child: const Text(
                                'use as guest',
                                style: TextStyle(
                                  fontSize: 38 / 2,
                                  color: Color(0xFF2D66AF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'By signing up you agree to our Privacy Policy. We never\nsell your data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 33 / 2,
                        color: Color(0xFF6A7891),
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BenefitLine extends StatelessWidget {
  const _BenefitLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: Color(0xFF28C663),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF617296),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
