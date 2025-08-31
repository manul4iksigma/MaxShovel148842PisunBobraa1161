import 'package:flutter/material.dart';

class ConnectContactsCard extends StatelessWidget {
  const ConnectContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1976D2),
            Color(0xFF1565C0),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Фоновые иконки людей (создаем паттерн программно)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
                painter: PeoplePatternPainter(),
              ),
            ),
          ),
          
          // Основной контент
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Подключите контакты',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Чтобы найти здесь знакомых',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 24,
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

class PeoplePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    const iconSize = 20.0;
    const spacing = 30.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        _drawPersonIcon(canvas, Offset(x, y), paint, iconSize);
      }
    }
  }

  void _drawPersonIcon(Canvas canvas, Offset center, Paint paint, double size) {
    // Рисуем простую иконку человека
    final path = Path();
    
    // Голова
    path.addOval(Rect.fromCenter(
      center: center,
      width: size * 0.4,
      height: size * 0.4,
    ));
    
    // Тело
    path.moveTo(center.dx, center.dy + size * 0.2);
    path.lineTo(center.dx, center.dy + size * 0.8);
    
    // Руки
    path.moveTo(center.dx - size * 0.3, center.dy + size * 0.4);
    path.lineTo(center.dx + size * 0.3, center.dy + size * 0.4);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
