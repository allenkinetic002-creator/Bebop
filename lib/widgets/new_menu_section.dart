import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/coffee_item.dart';

class NewMenuSection extends StatefulWidget {
  final List<CoffeeItem> items;
  final int currentPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<CoffeeItem>? onItemTap;

  const NewMenuSection({
    super.key,
    required this.items,
    this.currentPage = 0,
    this.onPageChanged,
    this.onItemTap,
  });

  @override
  State<NewMenuSection> createState() => _NewMenuSectionState();
}

class _NewMenuSectionState extends State<NewMenuSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Custom curved background with dashed line
        CustomPaint(
          size: Size(screenWidth, 300),
          painter: _NewMenuBackgroundPainter(),
        ),

        // Items Container
        SizedBox(
          height: 300,
          width: screenWidth,
          child: Column(
            children: [
              const SizedBox(height: 38),

              // 5 Circular Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    // Slightly arching offset for the items to match the curve
                    double topOffset = 0;
                    if (index == 0 || index == 4) {
                      topOffset = 24;
                    } else if (index == 1 || index == 3) {
                      topOffset = 8;
                    } else {
                      topOffset = 0; // center item peaks at the top of the wave
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: topOffset),
                      child: _MenuItemWidget(
                        item: item,
                        onAddTap: () {
                          setState(() {
                            item.isInCart = !item.isInCart;
                          });
                          widget.onItemTap?.call(item);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const Spacer(),

              // Pagination Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Active Pill
                  Container(
                    width: 22,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Inactive Pill
                  Container(
                    width: 22,
                    height: 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItemWidget extends StatelessWidget {
  final CoffeeItem item;
  final VoidCallback onAddTap;

  const _MenuItemWidget({
    required this.item,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with Dashed Circular Border
        CustomPaint(
          painter: _DashedCirclePainter(
            color: Colors.white.withOpacity(0.85),
            dashWidth: 4,
            dashSpace: 3,
            strokeWidth: 1.8,
          ),
          child: Container(
            width: 58,
            height: 58,
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: item.avatarColor,
                    alignment: Alignment.center,
                    child: Text(
                      item.initials,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Name
        SizedBox(
          width: 66,
          child: Text(
            item.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Add Button
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1,
              ),
            ),
            child: Icon(
              item.isInCart ? Icons.check : Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _NewMenuBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw dashed arc line above the wave
    final dashedPaint = Paint()
      ..color = const Color(0xFF013D29)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashedPath = Path();
    dashedPath.moveTo(0, 105);
    dashedPath.quadraticBezierTo(
      size.width * 0.5,
      -10,
      size.width,
      105,
    );

    _drawDashedPath(canvas, dashedPath, dashedPaint, 6, 4);

    // 2. Draw solid Dark Green Wave Hill
    final wavePaint = Paint()
      ..color = const Color(0xFF013D29)
      ..style = PaintingStyle.fill;

    final wavePath = Path();
    wavePath.moveTo(0, 115);
    wavePath.quadraticBezierTo(
      size.width * 0.5,
      0,
      size.width,
      115,
    );
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.drawPath(wavePath, wavePaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint, double dashWidth, double dashSpace) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final currentDashWidth = math.min(dashWidth, metric.length - distance);
        final extractPath = metric.extractPath(distance, distance + currentDashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  _DashedCirclePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final adjustedDashAngle = (dashWidth / circumference) * 2 * math.pi;
    final adjustedSpaceAngle = (dashSpace / circumference) * 2 * math.pi;

    double currentAngle = 0;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        currentAngle,
        adjustedDashAngle,
        false,
        paint,
      );
      currentAngle += adjustedDashAngle + adjustedSpaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
