import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller.dart';
import 'package:flutter_extension/views/base/auth_text_field.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  const SizedBox(height: 170),
                  const Center(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 76 / 2,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF11131A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "We'll send you a reset link",
                      style: TextStyle(
                        fontSize: 34 / 2,
                        color: Color(0xFF66779B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Enter the email address associated with your\naccount and we'll send you a link to reset your\npassword.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF66779B),
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 54),
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 18 + 7 / 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF172844),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AuthTextField(
                    controller: controller.forgotEmailController,
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
                  const SizedBox(height: 54),
                  CustomButton(
                    onTap: controller.sendResetLink,
                    text: 'Send Reset Link',
                    radius: 12,
                    height: 56,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF1F5CA8), Color(0xFF24B2A9)],
                    ),
                  ),
                  const SizedBox(height: 50),
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
