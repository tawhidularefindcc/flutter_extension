import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    super.key,
    required this.imageUrl,
    required this.country,
    required this.title,
    required this.description,
    required this.postedBy,
    required this.timeAgo,
  });

  final String imageUrl;
  final String country;
  final String title;
  final String description;
  final String postedBy;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
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
        title: const Text(
          'Migration News',
          style: TextStyle(
            color: AppColors.slate800,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.35,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Image.asset('assets/images/news.png', fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              country,
              style: const TextStyle(fontSize: 18, color: Color(0xFF5F6780)),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 38 / 2,
                fontWeight: FontWeight.w700,
                color: Color(0xFF11131A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$description This update introduces easier processing for high-demand roles and gives clearer migration pathways for new applicants.',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF66779B),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFDDE3EC)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0377CF),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'CN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Posted by $postedBy',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4D5068),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4F526B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
