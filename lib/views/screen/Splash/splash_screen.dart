import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.find<SplashController>().jumpNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F5AA9), Color(0xFF28B7A8)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(top: -80, right: -70, child: _bgCircle(220)),
            Positioned(top: 210, left: -50, child: _bgCircle(100)),
            Positioned(bottom: -120, left: -90, child: _bgCircle(320)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    _logoCard(),
                    const SizedBox(height: 30),
                    const Text(
                      'TuacasaAqui',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Find your ideal neighbourhood in minutes using\nreal territorial data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(flex: 3),
                    const Text(
                      'Powered By Official Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 42),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bgCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.10),
      ),
    );
  }

  Widget _logoCard() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Image.asset(
        'assets/icons/splash_logo.png',
        fit: BoxFit.contain,
        height: 136,
        width: 136,
      ),
    );
  }
}
