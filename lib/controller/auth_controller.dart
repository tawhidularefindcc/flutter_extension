import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController createEmailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();

  bool _signInPasswordHidden = true;
  bool _createPasswordHidden = true;
  String _resetEmail = 'email@example.com';

  bool get signInPasswordHidden => _signInPasswordHidden;
  bool get createPasswordHidden => _createPasswordHidden;
  String get resetEmail => _resetEmail;

  void toggleSignInPasswordVisibility() {
    _signInPasswordHidden = !_signInPasswordHidden;
    update();
  }

  void toggleCreatePasswordVisibility() {
    _createPasswordHidden = !_createPasswordHidden;
    update();
  }

  void goToSignIn() {
    Get.toNamed(AppRoutes.signInScreen);
  }

  void goToCreateAccount() {
    Get.toNamed(AppRoutes.createAccountScreen);
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
  }

  void continueAsGuest() {
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  void signIn() {
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  void createAccount() {
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  void sendResetLink() {
    final String value = forgotEmailController.text.trim();
    _resetEmail = value.isEmpty ? 'email@example.com' : value;
    update();
    Get.toNamed(AppRoutes.checkEmailScreen);
  }

  void backToSignIn() {
    Get.offAllNamed(AppRoutes.signInScreen);
  }

  @override
  void onClose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    fullNameController.dispose();
    createEmailController.dispose();
    createPasswordController.dispose();
    forgotEmailController.dispose();
    super.onClose();
  }
}
