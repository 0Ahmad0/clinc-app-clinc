import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../shared/extensions/context_extensions.dart';

/// The glowing hero icon used on the forgot (rounded, still) and pending
/// (circular, with a slowly rotating dashed ring) layers: a soft pulsing halo
/// behind a gradient shape holding a white line icon.
class AuthPulseBadge extends StatefulWidget {
  const AuthPulseBadge({
    super.key,
    required this.icon,
    required this.shapeSize,
    required this.haloSize,
    required this.iconSize,
    this.circle = false,
    this.ringSize,
  });

  final IconData icon;
  final double shapeSize;
  final double haloSize;
  final double iconSize;
  final bool circle;

  /// Diameter of the rotating dashed ring; null means no ring.
  final double? ringSize;

  @override
  State<AuthPulseBadge> createState() => _AuthPulseBadgeState();
}

class _AuthPulseBadgeState extends State<AuthPulseBadge>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3500),
  )..repeat(reverse: true);

  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: widget.haloSize,
      height: widget.haloSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing halo.
          FadeTransition(
            opacity: Tween(begin: 0.35, end: 0.7).animate(_pulse),
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.15).animate(_pulse),
              child: Container(
                width: widget.haloSize,
                height: widget.haloSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primary500.withValues(alpha: 0.10),
                ),
              ),
            ),
          ),
          // Rotating dashed ring (pending only).
          if (widget.ringSize != null)
            RotationTransition(
              turns: _spin,
              child: CustomPaint(
                size: Size.square(widget.ringSize!),
                painter: _DashedRingPainter(
                  color: colors.primary500.withValues(alpha: 0.35),
                ),
              ),
            ),
          // Gradient shape + icon.
          Container(
            width: widget.shapeSize,
            height: widget.shapeSize,
            decoration: BoxDecoration(
              gradient: colors.heroBadgeGradient,
              shape: widget.circle ? BoxShape.circle : BoxShape.rectangle,
              // ponytail: 32 is a one-off hero radius, not a reused token.
              borderRadius: widget.circle ? null : BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: colors.primary500.withValues(alpha: 0.55),
                  blurRadius: 34,
                  spreadRadius: -10,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              size: widget.iconSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a dashed circle stroke inset by half the stroke width.
class _DashedRingPainter extends CustomPainter {
  const _DashedRingPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final radius = (size.width - 2) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    const dashCount = 34;
    const gapRatio = 0.45; // portion of each slot left empty
    final slot = (2 * math.pi) / dashCount;
    final dash = slot * (1 - gapRatio);

    for (var i = 0; i < dashCount; i++) {
      final start = i * slot;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        dash,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter oldDelegate) =>
      oldDelegate.color != color;
}
