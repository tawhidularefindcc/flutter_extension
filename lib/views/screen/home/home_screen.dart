import 'package:flutter/material.dart';
import 'package:flutter_extension/views/screen/home/preferences_step_screen.dart';
import 'package:flutter_extension/views/screen/news/news_detail_screen.dart';
import 'package:flutter_extension/views/screen/news/news_feed_screen.dart';
import 'package:flutter_extension/views/screen/notifications/notifications_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String _newsImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/2/2a/Admiral_Kuznetsov_carrier.jpg';

const LinearGradient _primaryCardGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF1F5CA8), Color(0xFF24B2A9)],
);

const List<_NewsItem> _newsItems = [
  _NewsItem(
    country: 'Brazil',
    title: 'New Visa Rules for Skilled Tech Workers in 2026',
    description:
        'The government has announced new streamlined visa processing for high-',
    postedBy: 'Farnandp',
    timeAgo: '4h ago',
  ),
  _NewsItem(
    country: 'Brazil',
    title: 'New Visa Rules for Skilled Tech Workers in 2026',
    description:
        'The government has announced new streamlined visa processing for high-',
    postedBy: 'Farnandp',
    timeAgo: '4h ago',
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openWizard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PreferenceStepScreen(step: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 15.5.sp,
                            color: const Color(0xFF7A89A7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        const Text(
                          'Find your ideal area',
                          style: TextStyle(
                            fontSize: 39 / 2,
                            color: Color(0xFF11131A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    child: Ink(
                      width: 46.w,
                      height: 46.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EDF3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        size: 23.sp,
                        color: const Color(0xFF5C6780),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () => _openWizard(context),
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFD0D6E1)),
                    color: const Color(0xFFF3F5F9),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 26.sp,
                        color: const Color(0xFF6D7B96),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: const Color(0xFF6D7B96),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        size: 23.sp,
                        color: const Color(0xFF6D7B96),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.14,
                children: [
                  _QuickActionCard(
                    title: 'Find Best Areas',
                    subtitle: 'Run recommendation\nwizard',
                    icon: Icons.location_on_outlined,
                    selected: true,
                    onTap: () => _openWizard(context),
                  ),
                  _QuickActionCard(
                    title: 'Compare Zones',
                    subtitle: 'Side-by-side analysis',
                    icon: Icons.hub_outlined,
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    title: 'Renting Guide',
                    subtitle: 'Legal rights & processes',
                    icon: Icons.menu_book_outlined,
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    title: 'Compare Zones',
                    subtitle: 'Your zones and reports',
                    icon: Icons.bookmark_border_rounded,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Text(
                    'Migration News',
                    style: TextStyle(
                      fontSize: 22 / 1.95,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF11131A),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NewsFeedScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: const Color(0xFFF08A3A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 22.sp,
                          color: const Color(0xFFF08A3A),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 402.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _newsItems.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final _NewsItem item = _newsItems[index];
                    return _NewsCard(
                      item: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewsDetailScreen(
                              imageUrl: _newsImageUrl,
                              country: item.country,
                              title: item.title,
                              description: item.description,
                              postedBy: item.postedBy,
                              timeAgo: item.timeAgo,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              const Text(
                'Find your ideal area',
                style: TextStyle(
                  fontSize: 39 / 2,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF11131A),
                ),
              ),
              SizedBox(height: 12.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.16,
                children: const [
                  _AreaScoreCard(
                    title: 'Safety',
                    score: 71,
                    icon: Icons.shield_outlined,
                    accent: Color(0xFF2FA762),
                    iconColor: Color(0xFF2FA762),
                    iconBackground: Color(0xFFE2EFE8),
                  ),
                  _AreaScoreCard(
                    title: 'Schools',
                    score: 71,
                    icon: Icons.school_outlined,
                    accent: Color(0xFF0D87C6),
                    iconColor: Color(0xFF2A67BB),
                    iconBackground: Color(0xFFDFE8F4),
                  ),
                  _AreaScoreCard(
                    title: 'Transport',
                    score: 71,
                    icon: Icons.directions_transit_outlined,
                    accent: Color(0xFF24B2A9),
                    iconColor: Color(0xFF25AFA6),
                    iconBackground: Color(0xFFDFF0EF),
                  ),
                  _AreaScoreCard(
                    title: 'Budget Fit',
                    score: 71,
                    icon: Icons.attach_money_rounded,
                    accent: Color(0xFFEF9F10),
                    iconColor: Color(0xFFEF9F10),
                    iconBackground: Color(0xFFF5EBDD),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xFFD8DEEA)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD7E2F2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        size: 26.sp,
                        color: const Color(0xFF1F63B4),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Guest mode active',
                            style: TextStyle(
                              fontSize: 19 / 1.95,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF11131A),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Legal rights & processes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF6B7A97),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6E82A8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 10.w, 10.h),
        decoration: BoxDecoration(
          gradient: selected ? _primaryCardGradient : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFD1D7E1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: 0.16)
                    : const Color(0xFFE1E8F3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22.sp,
                color: selected ? Colors.white : const Color(0xFF2C67B9),
              ),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : const Color(0xFF11131A),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              subtitle,
              maxLines: selected ? 2 : 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: selected ? Colors.white : const Color(0xFF11131A),
                height: 1.18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item, required this.onTap});

  final _NewsItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        width: 296.w,
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE7EAF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                height: 194.h,
                width: double.infinity,
                child: Image.network(
                  _newsImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Image.asset('assets/images/news.png', fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              item.country,
              style: TextStyle(
                fontSize: 17 / 2,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF5E6781),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 22 / 2,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF11131A),
                height: 1.18,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.5 / 2,
                color: const Color(0xFF7180A0),
                height: 1.25,
              ),
            ),
            SizedBox(height: 9.h),
            const Divider(height: 1, color: Color(0xFFE2E7EF)),
            SizedBox(height: 9.h),
            Row(
              children: [
                Container(
                  width: 23.w,
                  height: 23.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0377CF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'CN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Posted By ${item.postedBy}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17 / 2,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4C4F67),
                    ),
                  ),
                ),
                Text(
                  'Read',
                  style: TextStyle(
                    fontSize: 16 / 2,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF304769),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 15.sp,
                  color: const Color(0xFF686E86),
                ),
                SizedBox(width: 4.w),
                Text(
                  item.timeAgo,
                  style: TextStyle(
                    fontSize: 16 / 2,
                    color: const Color(0xFF4F526B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AreaScoreCard extends StatelessWidget {
  const _AreaScoreCard({
    required this.title,
    required this.score,
    required this.icon,
    required this.accent,
    required this.iconColor,
    required this.iconBackground,
  });

  final String title;
  final int score;
  final IconData icon;
  final Color accent;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFD1D7E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 22.sp, color: iconColor),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 18 / 2,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF11131A),
            ),
          ),
          SizedBox(height: 6.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$score',
                  style: TextStyle(
                    fontSize: 45 / 2,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
                TextSpan(
                  text: '/100',
                  style: TextStyle(
                    fontSize: 17 / 2,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF11131A),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 9.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 7,
              child: Stack(
                children: [
                  Container(color: const Color(0xFFE6EAF0)),
                  FractionallySizedBox(
                    widthFactor: score / 100,
                    child: Container(color: accent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsItem {
  const _NewsItem({
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
