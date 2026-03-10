import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultCompareScreen extends StatefulWidget {
  const ResultCompareScreen({super.key});

  @override
  State<ResultCompareScreen> createState() => _ResultCompareScreenState();
}

class _ResultCompareScreenState extends State<ResultCompareScreen>
    with TickerProviderStateMixin {
  static const List<_MetricData> _metrics = [
    _MetricData(label: 'Safety', keyName: 'safety'),
    _MetricData(label: 'Schools', keyName: 'schools'),
    _MetricData(label: 'Transit', keyName: 'transit'),
    _MetricData(label: 'Price Index', keyName: 'price'),
  ];

  static const List<_ZoneData> _zones = [
    _ZoneData(
      id: 'belem',
      name: 'Belém',
      borderColor: Color(0xFF245DAA),
      chartColor: Color(0xFF245DAA),
      chartFill: Color(0x44245DAA),
      values: {
        'safety': 88,
        'schools': 85,
        'transit': 78,
        'price': 82,
        'quiet': 66,
      },
    ),
    _ZoneData(
      id: 'parque',
      name: 'Parque das Nações',
      borderColor: Color(0xFF24A89F),
      chartColor: Color(0xFF24A89F),
      chartFill: Color(0x4424A89F),
      values: {
        'safety': 90,
        'schools': 92,
        'transit': 95,
        'price': 58,
        'quiet': 62,
      },
    ),
    _ZoneData(
      id: 'alcantara',
      name: 'Alcantara',
      borderColor: Color(0xFFEFA11F),
      chartColor: Color(0xFFEFA11F),
      chartFill: Color(0x44EFA11F),
      values: {
        'safety': 75,
        'schools': 70,
        'transit': 88,
        'price': 76,
        'quiet': 56,
      },
    ),
  ];

  late final AnimationController _entryController;
  late final AnimationController _thirdZoneController;

  bool _showZonePicker = false;
  bool _includeThirdZone = false;

  List<_ZoneData> get _activeZones {
    if (_includeThirdZone) return _zones;
    return _zones.take(2).toList();
  }

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..forward();
    _thirdZoneController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _thirdZoneController.dispose();
    super.dispose();
  }

  void _openZonePicker() {
    if (_includeThirdZone) return;
    setState(() {
      _showZonePicker = true;
    });
  }

  void _closeZonePicker() {
    setState(() {
      _showZonePicker = false;
    });
  }

  void _addThirdZone() {
    setState(() {
      _showZonePicker = false;
      _includeThirdZone = true;
    });
    _thirdZoneController.forward(from: 0);
  }

  void _removeThirdZone() {
    setState(() {
      _includeThirdZone = false;
      _showZonePicker = false;
    });
    _thirdZoneController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([_entryController, _thirdZoneController]),
          builder: (context, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
              child: Column(
                children: [
                  _buildHeader(context),
                  SizedBox(height: 12.h),
                  _buildZoneRow(),
                  if (_showZonePicker && !_includeThirdZone) ...[
                    SizedBox(height: 10.h),
                    _buildZonePicker(),
                  ],
                  SizedBox(height: 10.h),
                  _buildTerritoryCard(),
                  SizedBox(height: 10.h),
                  _buildDetailedCard(),
                  SizedBox(height: 10.h),
                  _buildBestMatchCard(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 2.h, 0, 2.h),
      child: Row(
        children: [
          _SquareIconButton(
            onTap: () => Navigator.of(context).pop(),
            icon: Icons.arrow_back_ios_new_rounded,
            iconColor: const Color(0xFF25344A),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Compare Zones - Lisbon',
                  style: TextStyle(
                    color: const Color(0xFF1A202B),
                    fontSize: 36 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Up to 3 zones side by side',
                  style: TextStyle(
                    color: const Color(0xFF6C7A95),
                    fontSize: 16 / 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _SquareIconButton(
            onTap: () {},
            iconWidget: SvgPicture.asset(
              'assets/icons/compare.svg',
              width: 14.w,
              height: 14.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneRow() {
    return Row(
      children: [
        Expanded(
          child: _ZoneChip(data: _zones[0], onRemove: () {}),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _ZoneChip(data: _zones[1], onRemove: () {}),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _includeThirdZone
              ? _ZoneChip(data: _zones[2], onRemove: _removeThirdZone)
              : _AddZoneChip(onTap: _openZonePicker),
        ),
      ],
    );
  }

  Widget _buildZonePicker() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFC8D0DE)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 8.w, 8.h),
            child: Row(
              children: [
                Text(
                  'Select a zone',
                  style: TextStyle(
                    color: const Color(0xFF2A303A),
                    fontSize: 18 / 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  iconSize: 17.sp,
                  onPressed: _closeZonePicker,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF808EA8),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFD0D7E4)),
          InkWell(
            onTap: _addThirdZone,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
              child: Text(
                'Alcantara',
                style: TextStyle(
                  color: const Color(0xFF27303F),
                  fontSize: 19 / 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerritoryCard() {
    return _CompareCard(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TERRITORY COMPARISON',
              style: TextStyle(
                color: const Color(0xFF6E7E99),
                fontSize: 16 / 2,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 180.h,
              child: _RadarChart(
                zones: _activeZones,
                baseProgress: _entryController.value,
                thirdProgress: _thirdZoneController.value,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _activeZones
                  .map(
                    (zone) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: _LegendItem(
                        color: zone.chartColor,
                        label: zone.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedCard() {
    final List<_ZoneData> zones = _activeZones;
    return _CompareCard(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.swap_vert_rounded,
                  size: 14.sp,
                  color: const Color(0xFF8D9AB0),
                ),
                SizedBox(width: 6.w),
                Text(
                  'DETAILED COMPARISON',
                  style: TextStyle(
                    color: const Color(0xFF303844),
                    fontSize: 16 / 2,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFD1D8E3)),
          ...List<Widget>.generate(_metrics.length, (index) {
            final _MetricData metric = _metrics[index];
            final List<int> values = zones
                .map((zone) => zone.values[metric.keyName]!.toInt())
                .toList();
            final int maxValue = values.reduce(math.max);
            return Container(
              decoration: BoxDecoration(
                border: index == _metrics.length - 1
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFD1D8E3)),
                      ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 84.w,
                      child: Text(
                        metric.label,
                        style: TextStyle(
                          color: const Color(0xFF6A7893),
                          fontSize: 18 / 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ...List<Widget>.generate(zones.length, (zoneIndex) {
                      final _ZoneData zone = zones[zoneIndex];
                      final int value = values[zoneIndex];
                      final bool showTrophy = value == maxValue;
                      final double progress =
                          zone.id == 'alcantara' && _includeThirdZone
                          ? _thirdZoneController.value
                          : _entryController.value;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: _ValueBar(
                            value: value,
                            showTrophy: showTrophy,
                            barColor: zone.chartColor,
                            progress: progress,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBestMatchCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F4),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFC8E0D0)),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: Color(0xFFD9EEE0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              size: 16.sp,
              color: const Color(0xFF36A56B),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall best match',
                  style: TextStyle(
                    color: const Color(0xFF7A889F),
                    fontSize: 16 / 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Belém',
                  style: TextStyle(
                    color: const Color(0xFF2B9A5C),
                    fontSize: 20 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Details',
            style: TextStyle(
              color: const Color(0xFF2D5FA8),
              fontSize: 17 / 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.arrow_forward_rounded,
            size: 16.sp,
            color: const Color(0xFF2D5FA8),
          ),
        ],
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({
    required this.onTap,
    this.icon,
    this.iconWidget,
    this.iconColor = const Color(0xFF6B7893),
  });

  final VoidCallback onTap;
  final IconData? icon;
  final Widget? iconWidget;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Ink(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDF4),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: iconWidget ?? Icon(icon, size: 16.sp, color: iconColor),
        ),
      ),
    );
  }
}

class _ZoneChip extends StatelessWidget {
  const _ZoneChip({required this.data, required this.onRemove});

  final _ZoneData data;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: data.borderColor, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  data.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1D2430),
                    fontSize: 13 / 2,
                    fontWeight: FontWeight.w600,
                    height: 1.18,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              InkWell(
                onTap: onRemove,
                child: Icon(
                  Icons.close_rounded,
                  size: 14.sp,
                  color: const Color(0xFF6E7C95),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Container(
            width: 40.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD6DDE8),
              borderRadius: BorderRadius.circular(99.r),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 28.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: data.chartColor,
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddZoneChip extends StatelessWidget {
  const _AddZoneChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: const Color(0xFFC8D0DE),
          radius: 8.r,
        ),
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 15.sp, color: const Color(0xFF9AA7BC)),
              SizedBox(height: 1.h),
              Text(
                'Add zone',
                style: TextStyle(
                  color: const Color(0xFF9AA7BC),
                  fontSize: 12 / 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 3.w),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF6A7893),
            fontSize: 12 / 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ValueBar extends StatelessWidget {
  const _ValueBar({
    required this.value,
    required this.showTrophy,
    required this.barColor,
    required this.progress,
  });

  final int value;
  final bool showTrophy;
  final Color barColor;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: TextStyle(
                color: showTrophy
                    ? const Color(0xFF2AA65F)
                    : const Color(0xFF222A36),
                fontSize: 20 / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (showTrophy) ...[
              SizedBox(width: 2.w),
              Icon(
                Icons.workspace_premium_outlined,
                size: 11.sp,
                color: const Color(0xFF2AA65F),
              ),
            ],
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          height: 4.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFDDE3EC),
            borderRadius: BorderRadius.circular(99.r),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: ((value / 100) * progress).clamp(0.0, 1.0),
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RadarChart extends StatelessWidget {
  const _RadarChart({
    required this.zones,
    required this.baseProgress,
    required this.thirdProgress,
  });

  final List<_ZoneData> zones;
  final double baseProgress;
  final double thirdProgress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = math.min(constraints.maxWidth, 170.w);
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RadarChartPainter(
                      zones: zones,
                      baseProgress: baseProgress,
                      thirdProgress: thirdProgress,
                    ),
                  ),
                ),
                const _RadarLabels(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RadarLabels extends StatelessWidget {
  const _RadarLabels();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('Safety', style: _style),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Schools', style: _style),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 3),
              child: Text('Transit', style: _style),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 2),
              child: Text('Price Index', style: _style),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text('Quiet', style: _style),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _style {
    return const TextStyle(
      color: Color(0xFF7A889F),
      fontSize: 12 / 2,
      fontWeight: FontWeight.w600,
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  const _RadarChartPainter({
    required this.zones,
    required this.baseProgress,
    required this.thirdProgress,
  });

  final List<_ZoneData> zones;
  final double baseProgress;
  final double thirdProgress;

  static const List<String> _keys = [
    'safety',
    'schools',
    'transit',
    'price',
    'quiet',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.33;
    const int axisCount = 5;

    final Paint gridPaint = Paint()
      ..color = const Color(0xFFD1D8E3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int level = 1; level <= 5; level++) {
      final Path levelPath = Path();
      final double levelRadius = radius * (level / 5);
      for (int i = 0; i < axisCount; i++) {
        final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
        final Offset point = Offset(
          center.dx + math.cos(angle) * levelRadius,
          center.dy + math.sin(angle) * levelRadius,
        );
        if (i == 0) {
          levelPath.moveTo(point.dx, point.dy);
        } else {
          levelPath.lineTo(point.dx, point.dy);
        }
      }
      levelPath.close();
      canvas.drawPath(levelPath, gridPaint);
    }

    for (int i = 0; i < axisCount; i++) {
      final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
      final Offset point = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      canvas.drawLine(center, point, gridPaint);
    }

    for (final _ZoneData zone in zones) {
      final double progress = zone.id == 'alcantara'
          ? thirdProgress
          : baseProgress;
      final Path path = Path();
      for (int i = 0; i < axisCount; i++) {
        final double value = (zone.values[_keys[i]] ?? 0) * progress;
        final double valueRadius = radius * (value / 100).clamp(0.0, 1.0);
        final double angle = -math.pi / 2 + (2 * math.pi * i / axisCount);
        final Offset point = Offset(
          center.dx + math.cos(angle) * valueRadius,
          center.dy + math.sin(angle) * valueRadius,
        );
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();

      canvas.drawPath(
        path,
        Paint()
          ..color = zone.chartFill
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = zone.chartColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) {
    return oldDelegate.baseProgress != baseProgress ||
        oldDelegate.thirdProgress != thirdProgress ||
        oldDelegate.zones != zones;
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFC8D0DE)),
      ),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = math.min(distance + 4, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += 7;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

class _MetricData {
  const _MetricData({required this.label, required this.keyName});

  final String label;
  final String keyName;
}

class _ZoneData {
  const _ZoneData({
    required this.id,
    required this.name,
    required this.borderColor,
    required this.chartColor,
    required this.chartFill,
    required this.values,
  });

  final String id;
  final String name;
  final Color borderColor;
  final Color chartColor;
  final Color chartFill;
  final Map<String, double> values;
}
