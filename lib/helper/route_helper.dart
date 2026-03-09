import 'package:flutter_extension/views/screen/auth/auth_welcome_screen.dart';
import 'package:flutter_extension/views/screen/auth/check_email_screen.dart';
import 'package:flutter_extension/views/screen/auth/create_account_screen.dart';
import 'package:flutter_extension/views/screen/auth/forgot_password_screen.dart';
import 'package:flutter_extension/views/screen/auth/sign_in_screen.dart';
import 'package:flutter_extension/views/screen/main_screen.dart';
import 'package:flutter_extension/views/screen/onboarding/onboarding_screen.dart';
import 'package:get/get.dart';

import '../views/screen/Splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String onboardingScreen = "/onboarding_screen";
  static String authWelcomeScreen = "/auth_welcome_screen";
  static String signInScreen = "/sign_in_screen";
  static String createAccountScreen = "/create_account_screen";
  static String forgotPasswordScreen = "/forgot_password_screen";
  static String checkEmailScreen = "/check_email_screen";
  static String homeScreen = "/main_screen";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: authWelcomeScreen, page: () => const AuthWelcomeScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: createAccountScreen, page: () => const CreateAccountScreen()),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(name: checkEmailScreen, page: () => const CheckEmailScreen()),
    GetPage(name: homeScreen, page: () => const MainScreen()),
  ];
}
