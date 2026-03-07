import 'package:flutter/material.dart';

class OnboardingItemModel {
  final IconData icon;
  final String title;
  final String description;
  final List<String> benefits;

  const OnboardingItemModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.benefits,
  });
}
