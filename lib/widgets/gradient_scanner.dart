import 'dart:math';
import 'package:flutter/material.dart';

class GradientScanner extends StatefulWidget {
  final double size;
  final Color color;

  const GradientScanner({
    super.key,
    this.size = 200,
    this.color = Colors.cyanAccent,
  });

  @override
  State<GradientScanner> createState() => _GradientScannerState();
}

class _GradientScannerState extends State<GradientScanner>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _ScannerPainter(
            animationValue: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _ScannerPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _ScannerPainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Pulsing Background Radial Gradient
    // We create a subtle breathing effect by varying the radius slightly or opacity
    final pulse = sin(animationValue * 2 * pi) * 0.1 + 0.9; // 0.8 to 1.0
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: 0.2 * pulse),
          color.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, bgPaint);

    // 2. Rotating Sweep Gradient (The Scanner arm)
    // We rotate the canvas to simulate the scan
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animationValue * 2 * pi);

    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.5), // Tip of the scanner
        ],
        stops: const [0.0, 0.75, 1.0],
        startAngle: 0.0,
        endAngle: 0.5 * pi, // scanner width
        transform: const GradientRotation(0),
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius));

    // We draw an arc representing the scan area
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      -0.5 * pi, // Match the sweep logic
      0.5 * pi,
      true,
      sweepPaint,
    );

    canvas.restore();

    // 3. Center Glow (Core)
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [color.withValues(alpha: 0.6), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.2));

    canvas.drawCircle(center, radius * 0.2, corePaint);
  }

  @override
  bool shouldRepaint(covariant _ScannerPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color;
  }
}
