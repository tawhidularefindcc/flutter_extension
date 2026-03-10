import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/screen/main_screen.dart';
import 'package:get/get.dart';

class AnalyzingTerritoriesScreen extends StatefulWidget {
  const AnalyzingTerritoriesScreen({super.key});

  @override
  State<AnalyzingTerritoriesScreen> createState() =>
      _AnalyzingTerritoriesScreenState();
}

class _AnalyzingTerritoriesScreenState extends State<AnalyzingTerritoriesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _loaderController;
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && mounted) {
              Get.offAll(
                () => const MainScreen(initialIndex: 0),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 300),
              );
            }
          })
          ..forward();
  }

  @override
  void dispose() {
    _loaderController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 5),
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: _loaderController,
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: _loaderController.value * math.pi * 2,
                      child: CustomPaint(
                        size: const Size(42, 42),
                        painter: _ArcLoaderPainter(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Analysing Territories',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40 / 2,
                fontWeight: FontWeight.w700,
                color: Color(0xFF11131A),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                'Matching your preferences with official data\nfrom Lisbon',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34 / 2,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF66779B),
                  height: 1.15,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (context, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: SizedBox(
                      height: 8,
                      child: Stack(
                        children: [
                          Container(color: const Color(0xFFE6E8EC)),
                          FractionallySizedBox(
                            widthFactor: _progressController.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: AppColors.primaryGradient,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(flex: 7),
          ],
        ),
      ),
    );
  }
}

class _ArcLoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint arcPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, 0.35 * math.pi, 1.5 * math.pi, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
