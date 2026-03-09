import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

class LegalTextScreen extends StatelessWidget {
  const LegalTextScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.slate800,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.slate800,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'This is placeholder legal content based on the storyboard flow. Replace with final policy text and localized content once approved.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.slate500,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
