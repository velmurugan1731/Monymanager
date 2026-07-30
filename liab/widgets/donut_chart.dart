import 'dart:math';
import 'package:flutter/material.dart';

class DonutChartData {
  final String label;
  final double value;
  final Color color;
  DonutChartData({required this.label, required this.value, required this.color});
}

class DonutChart extends StatelessWidget {
  final List<DonutChartData> data;
  final double total;
  final String centerLabel;

  const DonutChart({
    super.key,
    required this.data,
    required this.total,
    required this.centerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(150, 150),
            painter: _DonutPainter(data: data, total: total),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('\u20B9${total.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              Text(centerLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<DonutChartData> data;
  final double total;

  _DonutPainter({required this.data, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const strokeWidth = 20.0;
    double startAngle = -pi / 2;

    if (total <= 0 || data.isEmpty) {
      final paint = Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawArc(rect.deflate(strokeWidth / 2), 0, 2 * pi, false, paint);
      return;
    }

    for (final d in data) {
      final sweep = (d.value / total) * 2 * pi;
      final paint = Paint()
        ..color = d.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect.deflate(strokeWidth / 2), startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => true;
}
