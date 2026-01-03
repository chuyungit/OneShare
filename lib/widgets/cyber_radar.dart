import 'dart:math';
import 'package:flutter/material.dart';

class CyberRadar extends StatefulWidget {
  final Widget? centerWidget;
  final bool isScanning;
  final Color? color;

  const CyberRadar({
    super.key,
    this.centerWidget,
    this.isScanning = true,
    this.color,
  });

  @override
  State<CyberRadar> createState() => _CyberRadarState();
}

class _CyberRadarState extends State<CyberRadar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void didUpdateWidget(CyberRadar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isScanning && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Painter
          CustomPaint(
            painter: _RadarPainter(
              animation: _controller,
              color: widget.color ?? Theme.of(context).colorScheme.primary,
            ),
            size: const Size(300, 300),
          ),
          // Center Content (e.g., SVG animation)
          if (widget.centerWidget != null) widget.centerWidget!,
        ],
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _RadarPainter({required this.animation, required this.color})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw concentric circles (Tech rings)
    for (int i = 1; i <= 3; i++) {
      double r = radius * (i / 3);

      // Dashed circle simulation
      if (i == 2) {
        _drawDashedCircle(canvas, center, r, paint);
      } else {
        canvas.drawCircle(center, r, paint);
      }
    }

    // Draw Sweep Gradient (The Radar Scan)
    final sweepRect = Rect.fromCircle(center: center, radius: radius);
    final sweepGradient = SweepGradient(
      startAngle: 0.0,
      endAngle: pi * 2,
      colors: [
        Colors.transparent,
        color.withValues(alpha: 0.1),
        color.withValues(alpha: 0.6),
      ],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(animation.value * pi * 2),
    );

    final sweepPaint = Paint()..shader = sweepGradient.createShader(sweepRect);

    canvas.drawCircle(center, radius, sweepPaint);

    // Draw "Tech" decorative lines
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..strokeWidth = 2;

    // Rotating lines
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-animation.value * pi); // Counter rotation

    canvas.drawLine(Offset(0, -radius * 0.8), Offset(0, -radius), linePaint);
    canvas.drawLine(Offset(0, radius * 0.8), Offset(0, radius), linePaint);
    canvas.drawLine(Offset(-radius * 0.8, 0), Offset(-radius, 0), linePaint);
    canvas.drawLine(Offset(radius * 0.8, 0), Offset(radius, 0), linePaint);

    canvas.restore();
  }

  void _drawDashedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const int dashCount = 20;
    const double dashLength = 2 * pi / dashCount;
    for (int i = 0; i < dashCount; i += 2) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * dashLength,
        dashLength / 1.5,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) => true;
}
