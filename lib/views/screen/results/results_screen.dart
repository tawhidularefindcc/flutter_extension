import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/screen/results/result_compare_screen.dart';
import 'package:flutter_extension/views/screen/results/result_detail_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

const List<_ZoneModel> _zones = [
  _ZoneModel(name: 'Belém', location: 'West Lisbon', rank: 1),
  _ZoneModel(name: 'Parque das Nações', location: 'East Lisbon', rank: 2),
  _ZoneModel(name: 'Alcântara', location: 'West-Central', rank: 3),
  _ZoneModel(name: 'Olivais', location: 'East Lisbon', rank: 4),
  _ZoneModel(name: 'Lumiar', location: 'North Lisbon', rank: 5),
];

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  Route<void> _slideRoute(Widget page) {
    return PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 260),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final Animation<Offset> offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              SizedBox(height: 12.h),
              const _ResultsMapCard(),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Text(
                    'Zone Rankings',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF11131A),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(_slideRoute(const ResultCompareScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/compare.svg'),
                          SizedBox(width: 4.w),
                          Text(
                            'Compare',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6F7FA2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ..._zones.map(
                (zone) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _ZoneRankingCard(zone: zone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(9.r),
          onTap: () {},
          child: Ink(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDF4),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: const Color(0xFF5B6780),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Results — Lisbon',
                style: TextStyle(
                  fontSize: 20 / 1.95,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF11131A),
                ),
              ),
              SizedBox(height: 2.h),
              const Text(
                '5 zones matched',
                style: TextStyle(
                  fontSize: 16.5 / 1.95,
                  color: Color(0xFF6E7DA0),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F3F8),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.map_outlined,
                size: 23.sp,
                color: const Color(0xFF2F3B55),
              ),
              SizedBox(width: 10.w),
              Container(width: 1, height: 22.h, color: const Color(0xFFD0D8E5)),
              SizedBox(width: 10.w),
              Icon(
                Icons.list_rounded,
                size: 23.sp,
                color: const Color(0xFF2F3B55),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultsMapCard extends StatefulWidget {
  const _ResultsMapCard();

  @override
  State<_ResultsMapCard> createState() => _ResultsMapCardState();
}

class _ResultsMapCardState extends State<_ResultsMapCard> {
  String? _selectedZoneId;

  _MapZone get _selectedZone {
    return _mapZones.firstWhere((zone) => zone.id == _selectedZoneId);
  }

  void _onZoneTap(String? zoneId) {
    setState(() {
      _selectedZoneId = zoneId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 316.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD8DEE8)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: _OsmResultsMap(
                selectedZoneId: _selectedZoneId,
                onZoneTap: _onZoneTap,
              ),
            ),
            if (_selectedZoneId != null)
              Positioned(
                left: 46.w,
                top: 68.h,
                child: _ZonePreviewCard(zone: _selectedZone),
              ),
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFD7DEE9)),
                ),
                child: const Row(
                  children: [
                    _LegendDot(label: 'High fit', color: Color(0xFF2AA862)),
                    _LegendDot(label: 'Mid fit', color: Color(0xFF2C67BB)),
                    _LegendDot(label: 'Lower Fit', color: Color(0xFFE5A521)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZonePreviewCard extends StatelessWidget {
  const _ZonePreviewCard({required this.zone});

  final _MapZone zone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148.w,
      height: 172.h,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4E5).withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF27A764), width: 1.3),
      ),
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
                      zone.location,
                      style: const TextStyle(
                        fontSize: 6,
                        color: Color(0xFF66779B),
                      ),
                    ),
                    Text(
                      zone.displayName,
                      style: const TextStyle(
                        fontSize: 8.4,
                        color: Color(0xFF11131A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF2AA862),
                    width: 1.4,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${zone.fitScore}',
                  style: const TextStyle(
                    fontSize: 8.43,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF24A05D),
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Fit Score',
              style: TextStyle(fontSize: 5.62, color: Color(0xFF7382A2)),
            ),
          ),
          SizedBox(height: 6.h),
          if (zone.bestMatch)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7EE),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/best_match.svg'),
                  SizedBox(width: 3.w),
                  const Text(
                    'Best Match',
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24A25E),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 7.h),
          _MapMetricRow(
            label: 'Safety',
            value: '${zone.safety}%',
            color: const Color(0xFF2AA862),
          ),
          _MapMetricRow(
            label: 'Schools',
            value: '${zone.schools}%',
            color: const Color(0xFF2A67BB),
          ),
          _MapMetricRow(
            label: 'Transport',
            value: '${zone.transport}%',
            color: const Color(0xFF2AA862),
          ),
          _MapMetricRow(
            label: 'Price',
            value: '${zone.price}%',
            color: const Color(0xFFECA220),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(6.r),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  transitionDuration: const Duration(milliseconds: 260),
                  reverseTransitionDuration: const Duration(milliseconds: 260),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ResultDetailScreen(
                        zone: zone.detailRouteName,
                        score: zone.fitScore,
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final Animation<Offset> offsetAnimation =
                            Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                )
                                .chain(CurveTween(curve: Curves.easeOutCubic))
                                .animate(animation);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 22.h,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(6.r),
              ),
              alignment: Alignment.center,
              child: const Text(
                'View Details  >',
                style: TextStyle(
                  fontSize: 9 / 2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OsmResultsMap extends StatefulWidget {
  const _OsmResultsMap({required this.selectedZoneId, required this.onZoneTap});

  final String? selectedZoneId;
  final ValueChanged<String?> onZoneTap;

  @override
  State<_OsmResultsMap> createState() => _OsmResultsMapState();
}

class _OsmResultsMapState extends State<_OsmResultsMap> {
  final LayerHitNotifier<String> _polygonHitNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _polygonHitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(38.7223, -9.1393),
        initialZoom: 11.7,
        minZoom: 10.5,
        maxZoom: 16.5,
        onTap: (_, __) {
          final List<String>? hits = _polygonHitNotifier.value?.hitValues;
          if (hits == null || hits.isEmpty) {
            widget.onZoneTap(null);
            return;
          }
          widget.onZoneTap(hits.last);
        },
        interactionOptions: const InteractionOptions(
          flags:
              InteractiveFlag.drag |
              InteractiveFlag.pinchZoom |
              InteractiveFlag.doubleTapZoom |
              InteractiveFlag.flingAnimation,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.betopiagroup.tuacasaaqui',
        ),
        PolygonLayer<String>(
          hitNotifier: _polygonHitNotifier,
          polygons: _mapZones.map((zone) {
            final bool selected = widget.selectedZoneId == zone.id;
            return Polygon<String>(
              points: zone.polygon,
              hitValue: zone.id,
              color: zone.fill.withValues(alpha: selected ? 0.38 : 0.28),
              borderColor: zone.border,
              borderStrokeWidth: selected ? 2.0 : 1.3,
            );
          }).toList(),
        ),
      ],
    );
  }
}

final List<_MapZone> _mapZones = [
  _MapZone(
    id: 'belem',
    displayName: 'Belém',
    detailRouteName: 'Belém',
    location: 'West Lisbon',
    fitScore: 91,
    safety: 88,
    schools: 85,
    transport: 78,
    price: 82,
    bestMatch: true,
    fill: const Color(0xFF2AA862),
    border: const Color(0xFF2AA862),
    polygon: const [
      LatLng(38.709, -9.227),
      LatLng(38.705, -9.214),
      LatLng(38.696, -9.202),
      LatLng(38.691, -9.216),
      LatLng(38.699, -9.229),
    ],
  ),
  _MapZone(
    id: 'parque',
    displayName: 'Parque das Nações',
    detailRouteName: 'Parque das Nações',
    location: 'East Lisbon',
    fitScore: 87,
    safety: 90,
    schools: 92,
    transport: 95,
    price: 58,
    fill: const Color(0xFF2D66BC),
    border: const Color(0xFF2D66BC),
    polygon: const [
      LatLng(38.782, -9.112),
      LatLng(38.778, -9.086),
      LatLng(38.763, -9.079),
      LatLng(38.753, -9.101),
      LatLng(38.766, -9.118),
    ],
  ),
  _MapZone(
    id: 'alcantara',
    displayName: 'Alcantara',
    detailRouteName: 'Alcântara',
    location: 'West-Central',
    fitScore: 81,
    safety: 75,
    schools: 70,
    transport: 88,
    price: 76,
    fill: const Color(0xFFE6A521),
    border: const Color(0xFFE6A521),
    polygon: const [
      LatLng(38.715, -9.196),
      LatLng(38.712, -9.175),
      LatLng(38.695, -9.169),
      LatLng(38.691, -9.184),
      LatLng(38.701, -9.199),
    ],
  ),
];

class _MapZone {
  const _MapZone({
    required this.id,
    required this.displayName,
    required this.detailRouteName,
    required this.location,
    required this.fitScore,
    required this.safety,
    required this.schools,
    required this.transport,
    required this.price,
    required this.fill,
    required this.border,
    required this.polygon,
    this.bestMatch = false,
  });

  final String id;
  final String displayName;
  final String detailRouteName;
  final String location;
  final int fitScore;
  final int safety;
  final int schools;
  final int transport;
  final int price;
  final bool bestMatch;
  final Color fill;
  final Color border;
  final List<LatLng> polygon;
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12 / 2,
              color: Color(0xFF6B7A98),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapMetricRow extends StatelessWidget {
  const _MapMetricRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 5.62,
                color: Color(0xFF55688F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 7.02,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneRankingCard extends StatelessWidget {
  const _ZoneRankingCard({required this.zone});

  final _ZoneModel zone;

  @override
  Widget build(BuildContext context) {
    final _ZoneStats stats = _zoneStatsForRank(zone.rank);
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFD8DEE8)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#${zone.rank}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF65779B),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: Text(
                            zone.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF11131A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (stats.bestMatch) ...[
                          SizedBox(width: 8.w),
                          SvgPicture.asset(
                            'assets/icons/best_match.svg',
                            width: 14.w,
                            height: 14.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Best Match',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF24A25E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: const Color(0xFF6D7C99),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          zone.location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6D7C99),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                        color: const Color(0xFF2AA862),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${stats.score}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xFF24A25E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Fit Score',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF6E7DA0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats.metrics
                .map(
                  (metric) => _MetricBlock(
                    icon: metric.icon,
                    label: metric.label,
                    value: '${metric.value}%',
                    valueColor: metric.valueColor,
                    iconColor: metric.iconColor,
                    iconBg: metric.iconBg,
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder<void>(
                        transitionDuration: const Duration(milliseconds: 260),
                        reverseTransitionDuration: const Duration(
                          milliseconds: 260,
                        ),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ResultDetailScreen(
                            zone: zone.name,
                            score: stats.score,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              final Animation<Offset> offsetAnimation =
                                  Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      )
                                      .chain(
                                        CurveTween(curve: Curves.easeOutCubic),
                                      )
                                      .animate(animation);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'View detail →',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              _SquareActionButton(
                icon: 'assets/icons/compare.svg',
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      transitionDuration: const Duration(milliseconds: 260),
                      reverseTransitionDuration: const Duration(
                        milliseconds: 260,
                      ),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const ResultCompareScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            final Animation<Offset> offsetAnimation =
                                Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero,
                                    )
                                    .chain(
                                      CurveTween(curve: Curves.easeOutCubic),
                                    )
                                    .animate(animation);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
              ),
              SizedBox(width: 8.w),
              _SquareActionButton(
                icon: 'assets/icons/bookmark.svg',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricBlock extends StatelessWidget {
  const _MetricBlock({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.iconColor,
    required this.iconBg,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;
  final Color iconColor;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66.w,
      child: Column(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(4.r),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 13.sp, color: iconColor),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F2EB),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF6E7DA0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SquareActionButton extends StatelessWidget {
  const _SquareActionButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDF4),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SvgPicture.asset(icon),
        ),
      ),
    );
  }
}

class _ZoneModel {
  const _ZoneModel({
    required this.name,
    required this.location,
    required this.rank,
  });

  final String name;
  final String location;
  final int rank;
}

_ZoneStats _zoneStatsForRank(int rank) {
  switch (rank) {
    case 1:
      return const _ZoneStats(
        score: 91,
        bestMatch: true,
        metrics: [
          _ZoneMetric(
            icon: Icons.shield_outlined,
            label: 'Safety',
            value: 88,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2AA862),
            iconBg: Color(0xFFE1EEE8),
          ),
          _ZoneMetric(
            icon: Icons.school_outlined,
            label: 'Schools',
            value: 85,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2A67BB),
            iconBg: Color(0xFFE3EAF4),
          ),
          _ZoneMetric(
            icon: Icons.directions_transit_outlined,
            label: 'Transit',
            value: 78,
            valueColor: Color(0xFFE7A41E),
            iconColor: Color(0xFF2AAEA4),
            iconBg: Color(0xFFDFF0EF),
          ),
          _ZoneMetric(
            icon: Icons.attach_money_rounded,
            label: 'Price',
            value: 82,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFFE7A41E),
            iconBg: Color(0xFFF4EBDF),
          ),
        ],
      );
    case 2:
      return const _ZoneStats(
        score: 87,
        bestMatch: false,
        metrics: [
          _ZoneMetric(
            icon: Icons.shield_outlined,
            label: 'Safety',
            value: 90,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2AA862),
            iconBg: Color(0xFFE1EEE8),
          ),
          _ZoneMetric(
            icon: Icons.school_outlined,
            label: 'Schools',
            value: 92,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2A67BB),
            iconBg: Color(0xFFE3EAF4),
          ),
          _ZoneMetric(
            icon: Icons.directions_transit_outlined,
            label: 'Transit',
            value: 95,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2AAEA4),
            iconBg: Color(0xFFDFF0EF),
          ),
          _ZoneMetric(
            icon: Icons.attach_money_rounded,
            label: 'Price',
            value: 58,
            valueColor: Color(0xFFE66C6C),
            iconColor: Color(0xFFE7A41E),
            iconBg: Color(0xFFF4EBDF),
          ),
        ],
      );
    default:
      return const _ZoneStats(
        score: 81,
        bestMatch: false,
        metrics: [
          _ZoneMetric(
            icon: Icons.shield_outlined,
            label: 'Safety',
            value: 75,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2AA862),
            iconBg: Color(0xFFE1EEE8),
          ),
          _ZoneMetric(
            icon: Icons.school_outlined,
            label: 'Schools',
            value: 70,
            valueColor: Color(0xFF2A67BB),
            iconColor: Color(0xFF2A67BB),
            iconBg: Color(0xFFE3EAF4),
          ),
          _ZoneMetric(
            icon: Icons.directions_transit_outlined,
            label: 'Transit',
            value: 88,
            valueColor: Color(0xFF2AA862),
            iconColor: Color(0xFF2AAEA4),
            iconBg: Color(0xFFDFF0EF),
          ),
          _ZoneMetric(
            icon: Icons.attach_money_rounded,
            label: 'Price',
            value: 76,
            valueColor: Color(0xFFE7A41E),
            iconColor: Color(0xFFE7A41E),
            iconBg: Color(0xFFF4EBDF),
          ),
        ],
      );
  }
}

class _ZoneStats {
  const _ZoneStats({
    required this.score,
    required this.bestMatch,
    required this.metrics,
  });

  final int score;
  final bool bestMatch;
  final List<_ZoneMetric> metrics;
}

class _ZoneMetric {
  const _ZoneMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.iconColor,
    required this.iconBg,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color valueColor;
  final Color iconColor;
  final Color iconBg;
}
