import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class ResultDetailScreen extends StatefulWidget {
  const ResultDetailScreen({
    super.key,
    required this.zone,
    required this.score,
  });

  final String zone;
  final int score;

  @override
  State<ResultDetailScreen> createState() => _ResultDetailScreenState();
}

class _ResultDetailScreenState extends State<ResultDetailScreen>
    with SingleTickerProviderStateMixin {
  late final _ZoneDetailData _data = _dataForZone(widget.zone, widget.score);
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 620),
  )..forward();
  late final Animation<double> _barReveal = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0.0, 0.52, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _radarReveal = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0.24, 1.0, curve: Curves.easeOutCubic),
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Column(
        children: [
          _DetailHeader(data: _data),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MapAndBreakdownCard(data: _data, reveal: _barReveal),
                  SizedBox(height: 14.h),
                  Text(
                    'Territory Profile',
                    style: TextStyle(
                      color: const Color(0xFF11131A),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AnimatedBuilder(
                    animation: _radarReveal,
                    builder: (context, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 250.h,
                        child: _SingleRadarChart(
                          values: _data.radarValues,
                          progress: _radarReveal.value,
                          strokeColor: const Color(0xFF255FAE),
                          fillColor: const Color(0x4D255FAE),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 14.h),
                  _DetailCard(
                    color: const Color(0xFFE8EEF4),
                    borderColor: const Color(0xFFE8EEF4),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About this zone',
                            style: TextStyle(
                              color: const Color(0xFF11131A),
                              fontSize: 17 / 2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            _data.aboutText,
                            style: TextStyle(
                              color: const Color(0xFF63749A),
                              fontSize: 15 / 2,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _DetailCard(
                    color: const Color(0xFFDDEBDD),
                    borderColor: const Color(0xFFCCDDCC),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account benefits',
                            style: TextStyle(
                              color: const Color(0xFF1DB954),
                              fontSize: 17 / 2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ..._data.strengths.map(
                            (item) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: _LineBullet(text: item, positive: true),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _DetailCard(
                    color: const Color(0xFFEBE3D5),
                    borderColor: const Color(0xFFE0D2BD),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account benefits',
                            style: TextStyle(
                              color: const Color(0xFFF0A11E),
                              fontSize: 17 / 2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ..._data.considerations.map(
                            (item) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: _LineBullet(text: item, positive: false),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  _ActionButton(
                    text: 'Save',
                    iconAsset: 'assets/icons/bookmark.svg',
                    filled: false,
                    muted: false,
                    onTap: () {},
                  ),
                  SizedBox(height: 10.h),
                  _ActionButton(
                    text: 'Export Report',
                    iconData: Icons.file_upload_outlined,
                    filled: true,
                    muted: false,
                    onTap: () {},
                  ),
                  SizedBox(height: 10.h),
                  _ActionButton(
                    text: 'Read Renting Guide',
                    iconAsset: 'assets/icons/reading.svg',
                    filled: false,
                    muted: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _ZoneDetailData _dataForZone(String zone, int fallbackScore) {
    final String normalized = zone.toLowerCase();

    if (normalized.contains('alc')) {
      return const _ZoneDetailData(
        displayName: 'Alcântara',
        location: 'West-Central',
        fitScore: 81,
        metrics: [
          _ScoreMetric(label: 'Safety', score: 75, color: Color(0xFF2FA763)),
          _ScoreMetric(label: 'School', score: 70, color: Color(0xFF275BAC)),
          _ScoreMetric(label: 'Transit', score: 88, color: Color(0xFF2AA39D)),
          _ScoreMetric(label: 'Price', score: 76, color: Color(0xFFF09F18)),
        ],
        radarValues: [75, 70, 88, 76, 62],
        aboutText:
            'A transitional zone undergoing urban renewal. Great transport access, growing cultural scene.',
        strengths: [
          'Excellent transport access',
          'Up-and-coming vibe',
          'Reasonable prices',
        ],
        considerations: [
          'Safety below top zones',
          'Fewer schools in catchment',
        ],
        mapCenter: LatLng(38.705, -9.1845),
        mapZoom: 13.9,
        mapTone: Color(0xFF2E65BB),
        polygon: [
          LatLng(38.719, -9.207),
          LatLng(38.717, -9.168),
          LatLng(38.692, -9.158),
          LatLng(38.688, -9.180),
          LatLng(38.702, -9.204),
        ],
      );
    }

    if (normalized.contains('parque') || normalized.contains('na')) {
      return const _ZoneDetailData(
        displayName: 'Parque das Nações',
        location: 'East Lisbon',
        fitScore: 87,
        metrics: [
          _ScoreMetric(label: 'Safety', score: 90, color: Color(0xFF2FA763)),
          _ScoreMetric(label: 'School', score: 92, color: Color(0xFF275BAC)),
          _ScoreMetric(label: 'Transit', score: 95, color: Color(0xFF2AA39D)),
          _ScoreMetric(label: 'Price', score: 58, color: Color(0xFFF09F18)),
        ],
        radarValues: [90, 92, 95, 58, 65],
        aboutText:
            'A modern waterfront district with strong infrastructure, schools, and public transport.',
        strengths: [
          'Top-performing schools',
          'Excellent transit connectivity',
          'Modern amenities',
        ],
        considerations: [
          'Higher housing costs in prime pockets',
          'Less historic neighborhood character',
        ],
        mapCenter: LatLng(38.770, -9.101),
        mapZoom: 13.9,
        mapTone: Color(0xFF2E65BB),
        polygon: [
          LatLng(38.784, -9.120),
          LatLng(38.783, -9.083),
          LatLng(38.759, -9.075),
          LatLng(38.750, -9.099),
          LatLng(38.764, -9.123),
        ],
      );
    }

    if (normalized.contains('bel')) {
      return const _ZoneDetailData(
        displayName: 'Belém',
        location: 'West Lisbon',
        fitScore: 91,
        metrics: [
          _ScoreMetric(label: 'Safety', score: 88, color: Color(0xFF2FA763)),
          _ScoreMetric(label: 'School', score: 88, color: Color(0xFF275BAC)),
          _ScoreMetric(label: 'Transit', score: 78, color: Color(0xFF2AA39D)),
          _ScoreMetric(label: 'Price', score: 82, color: Color(0xFFF09F18)),
        ],
        radarValues: [88, 85, 78, 82, 70],
        aboutText:
            'A historic riverside neighbourhood with good safety scores, access to cultural infrastructure, and strong school density.',
        strengths: [
          'Top-rated safety score',
          'Strong school density',
          'Riverside location',
          'Good price-to-quality ratio',
        ],
        considerations: ['Higher weekend tourist activity', 'Considerations'],
        mapCenter: LatLng(38.697, -9.215),
        mapZoom: 14.15,
        mapTone: Color(0xFF2FA763),
        polygon: [
          LatLng(38.709, -9.236),
          LatLng(38.707, -9.201),
          LatLng(38.691, -9.194),
          LatLng(38.684, -9.222),
          LatLng(38.698, -9.238),
        ],
      );
    }

    final int clampedScore = fallbackScore.clamp(0, 100);
    return _ZoneDetailData(
      displayName: zone,
      location: 'Lisbon',
      fitScore: clampedScore,
      metrics: [
        const _ScoreMetric(
          label: 'Safety',
          score: 84,
          color: Color(0xFF2FA763),
        ),
        const _ScoreMetric(
          label: 'School',
          score: 82,
          color: Color(0xFF275BAC),
        ),
        const _ScoreMetric(
          label: 'Transit',
          score: 80,
          color: Color(0xFF2AA39D),
        ),
        const _ScoreMetric(label: 'Price', score: 72, color: Color(0xFFF09F18)),
      ],
      radarValues: const [84, 82, 80, 72, 64],
      aboutText:
          'A balanced mixed-use area with access to core services and transport.',
      strengths: const [
        'Balanced profile across key metrics',
        'Well-connected streets and transit',
        'Good access to daily amenities',
      ],
      considerations: const [
        'Varies by micro-location',
        'Some older housing stock',
      ],
      mapCenter: const LatLng(38.7223, -9.1393),
      mapZoom: 12.8,
      mapTone: clampedScore >= 90
          ? const Color(0xFF2FA763)
          : clampedScore >= 80
          ? const Color(0xFF2E65BB)
          : const Color(0xFFF09F18),
      polygon: const [
        LatLng(38.741, -9.186),
        LatLng(38.744, -9.120),
        LatLng(38.703, -9.084),
        LatLng(38.681, -9.150),
      ],
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.data});

  final _ZoneDetailData data;

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, topInset + 8.h, 16.w, 14.h),
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () => Navigator.of(context).pop(),
            child: Ink(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.26),
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Results — Lisbon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '5 zones matched',
                    style: TextStyle(
                      color: const Color(0xCCFFFFFF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.9),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${data.fitScore}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Fit Score',
                style: TextStyle(
                  color: const Color(0xCCFFFFFF),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapAndBreakdownCard extends StatelessWidget {
  const _MapAndBreakdownCard({required this.data, required this.reveal});

  final _ZoneDetailData data;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD0D8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 190.h,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: data.mapCenter,
                        initialZoom: data.mapZoom,
                        minZoom: data.mapZoom,
                        maxZoom: data.mapZoom,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.betopiagroup.tuacasaaqui',
                        ),
                        PolygonLayer(
                          polygons: [
                            Polygon(
                              points: data.polygon,
                              color: data.mapTone.withValues(alpha: 0.32),
                              borderColor: data.mapTone,
                              borderStrokeWidth: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: data.mapTone.withValues(alpha: 0.12),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    bottom: 10.h,
                    child: Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FBFF),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFCAD4E3)),
                      ),
                      child: const Row(
                        children: [
                          _LegendDot(
                            color: Color(0xFF2FA763),
                            label: 'High fit',
                          ),
                          _LegendDot(
                            color: Color(0xFF275BAC),
                            label: 'Mid fit',
                          ),
                          _LegendDot(
                            color: Color(0xFFF09F18),
                            label: 'Lower Fit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: const Color(0xFFD4DCE6), height: 1.h, thickness: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score Breakdown',
                  style: TextStyle(
                    color: const Color(0xFF11131A),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: data.metrics
                      .map(
                        (metric) => Expanded(
                          child: _AnimatedMetricColumn(
                            metric: metric,
                            reveal: reveal,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedMetricColumn extends StatelessWidget {
  const _AnimatedMetricColumn({required this.metric, required this.reveal});

  final _ScoreMetric metric;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: reveal,
            builder: (context, child) {
              final double heightFactor = reveal.value.clamp(0.02, 1.0);
              return SizedBox(
                width: double.infinity,
                height: 84.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: heightFactor,
                    widthFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: metric.color,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8.h),
          Text(
            metric.label,
            style: TextStyle(
              color: const Color(0xFF63739A),
              fontSize: 16 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${metric.score}',
                  style: TextStyle(
                    color: const Color(0xFF5F729A),
                    fontSize: 31 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '/100',
                  style: TextStyle(
                    color: const Color(0xFF5F729A),
                    fontSize: 31 / 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF6B7893),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.child,
    this.color = Colors.white,
    this.borderColor = const Color(0xFFD8DFE8),
  });

  final Widget child;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class _LineBullet extends StatelessWidget {
  const _LineBullet({required this.text, required this.positive});

  final String text;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = positive
        ? const Color(0xFF2EBE5B)
        : const Color(0xFFF0A11E);
    return Row(
      children: [
        Icon(
          positive
              ? Icons.check_circle_outline_rounded
              : Icons.info_outline_rounded,
          size: 16.sp,
          color: iconColor,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF63749A),
              fontSize: 17 / 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.text,
    required this.filled,
    required this.muted,
    required this.onTap,
    this.iconData,
    this.iconAsset,
  });

  final String text;
  final IconData? iconData;
  final String? iconAsset;
  final bool filled;
  final bool muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color textColor = filled
        ? Colors.white
        : muted
        ? const Color(0xFF6D7C9A)
        : const Color(0xFF556786);
    final Color iconColor = filled
        ? Colors.white
        : muted
        ? const Color(0xFF6D7C9A)
        : const Color(0xFF556786);

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: filled ? AppColors.primaryGradient : null,
          color: filled
              ? null
              : muted
              ? const Color(0xFFF2F4F8)
              : Colors.white,
          border: filled
              ? null
              : Border.all(
                  color: muted
                      ? const Color(0xFF8D9AB4)
                      : const Color(0xFF8D9AB4),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAsset != null)
              SvgPicture.asset(
                iconAsset!,
                width: 19.w,
                height: 19.w,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            if (iconData != null) Icon(iconData, size: 20.sp, color: iconColor),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleRadarChart extends StatelessWidget {
  const _SingleRadarChart({
    required this.values,
    required this.progress,
    required this.strokeColor,
    required this.fillColor,
  });

  final List<double> values;
  final double progress;
  final Color strokeColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = math.min(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _SingleRadarPainter(
                values: values,
                progress: progress,
                strokeColor: strokeColor,
                fillColor: fillColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SingleRadarPainter extends CustomPainter {
  const _SingleRadarPainter({
    required this.values,
    required this.progress,
    required this.strokeColor,
    required this.fillColor,
  });

  final List<double> values;
  final double progress;
  final Color strokeColor;
  final Color fillColor;

  static const List<String> _labels = [
    'Safety',
    'Schools',
    'Transport',
    'Price',
    'Quiet',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.34;
    const int axisCount = 5;

    final Paint grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFD1D8E3);

    for (int level = 1; level <= 5; level++) {
      final ui.Path path = ui.Path();
      final double levelRadius = radius * (level / 5);
      for (int i = 0; i < axisCount; i++) {
        final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
        final Offset point = Offset(
          center.dx + math.cos(angle) * levelRadius,
          center.dy + math.sin(angle) * levelRadius,
        );
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, grid);
    }

    for (int i = 0; i < axisCount; i++) {
      final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
      final Offset point = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      canvas.drawLine(center, point, grid);
    }

    final ui.Path valuePath = ui.Path();
    for (int i = 0; i < axisCount; i++) {
      final double value = values[i].clamp(0, 100);
      final double valueRadius = radius * ((value / 100) * progress);
      final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
      final Offset point = Offset(
        center.dx + math.cos(angle) * valueRadius,
        center.dy + math.sin(angle) * valueRadius,
      );
      if (i == 0) {
        valuePath.moveTo(point.dx, point.dy);
      } else {
        valuePath.lineTo(point.dx, point.dy);
      }
    }
    valuePath.close();
    canvas.drawPath(
      valuePath,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      valuePath,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawCircle(
      center,
      2.2,
      Paint()..color = strokeColor.withValues(alpha: 0.9),
    );

    final TextPainter tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < axisCount; i++) {
      final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
      final Offset labelPoint = Offset(
        center.dx + math.cos(angle) * (radius + 12),
        center.dy + math.sin(angle) * (radius + 12),
      );
      tp.text = TextSpan(
        text: _labels[i],
        style: TextStyle(
          color: const Color(0xFF7D8CA5),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(labelPoint.dx - tp.width / 2, labelPoint.dy - tp.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SingleRadarPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        values != oldDelegate.values ||
        strokeColor != oldDelegate.strokeColor ||
        fillColor != oldDelegate.fillColor;
  }
}

class _ZoneDetailData {
  const _ZoneDetailData({
    required this.displayName,
    required this.location,
    required this.fitScore,
    required this.metrics,
    required this.radarValues,
    required this.aboutText,
    required this.strengths,
    required this.considerations,
    required this.mapCenter,
    required this.mapZoom,
    required this.mapTone,
    required this.polygon,
  });

  final String displayName;
  final String location;
  final int fitScore;
  final List<_ScoreMetric> metrics;
  final List<double> radarValues;
  final String aboutText;
  final List<String> strengths;
  final List<String> considerations;
  final LatLng mapCenter;
  final double mapZoom;
  final Color mapTone;
  final List<LatLng> polygon;
}

class _ScoreMetric {
  const _ScoreMetric({
    required this.label,
    required this.score,
    required this.color,
  });

  final String label;
  final int score;
  final Color color;
}
