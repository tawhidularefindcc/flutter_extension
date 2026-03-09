import 'package:flutter/material.dart';
import 'package:flutter_extension/views/screen/news/news_detail_screen.dart';

const String _newsImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/2/2a/Admiral_Kuznetsov_carrier.jpg';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_NewsArticle> articles = List.generate(
      6,
      (_) => const _NewsArticle(
        country: 'Brazil',
        title: 'New Visa Rules for Skilled Tech Workers in 2026',
        description:
            'The government has announced new streamlined visa processing.',
        postedBy: 'Farnandp',
        timeAgo: '4h ago',
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF11131A),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Migration News',
          style: TextStyle(
            color: Color(0xFF11131A),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: articles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final _NewsArticle article = articles[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(
                    imageUrl: _newsImageUrl,
                    country: article.country,
                    title: article.title,
                    description: article.description,
                    postedBy: article.postedBy,
                    timeAgo: article.timeAgo,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE7EAF0)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 110,
                      height: 90,
                      child: Image.network(
                        _newsImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/news.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.country,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5F6780),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF11131A),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${article.postedBy} • ${article.timeAgo}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF66779B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NewsArticle {
  const _NewsArticle({
    required this.country,
    required this.title,
    required this.description,
    required this.postedBy,
    required this.timeAgo,
  });

  final String country;
  final String title;
  final String description;
  final String postedBy;
  final String timeAgo;
}
