import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final customPaint = CustomPaint(
  painter: EmotionalRoulettePainter(),
  child: GestureDetector(
    onPanDown: (details) {
      print('Tapped $details');
    },
  ),
);

class EmotionalRoulettePainter extends CustomPainter {
  final sections = [
    'Anger',
    'Disgust',
    'Fear',
    'Happiness',
    'Sadness',
    'Surprise',
  ];
  final colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback get semanticsBuilder => (size) {
        final rect = Offset.zero & size;
        return [
          CustomPainterSemantics(
            rect: rect,
            properties: const SemanticsProperties(
              label: 'Emotional Roulette',
              textDirection: TextDirection.ltr,
            ),
          ),
        ];
      };

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    final sectionAngle = 2 * 3.14 / sections.length;
    for (var i = 0; i < sections.length; i++) {
      final sectionPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      final startAngle = i * sectionAngle;
      final endAngle = (i + 1) * sectionAngle;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sectionAngle,
          false,
        )
        ..lineTo(center.dx, center.dy);
      canvas.drawPath(path, sectionPaint);
    }
  }
}

class EmotionalRoulette extends StatelessWidget {
  const EmotionalRoulette({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: customPaint,
    );
  }
}
