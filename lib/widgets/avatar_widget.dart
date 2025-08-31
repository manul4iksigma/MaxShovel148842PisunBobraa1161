import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String name;
  final double size;

  const AvatarWidget({
    super.key,
    required this.name,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _getAvatarGradient(),
      ),
      child: Center(
        child: Text(
          _getInitials(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials() {
    if (name.contains('MAX') && !name.contains('GigaChat')) {
      return 'M';
    } else if (name.contains('GigaChat')) {
      return 'G';
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  LinearGradient _getAvatarGradient() {
    if (name.contains('MAX') && !name.contains('GigaChat')) {
      return const LinearGradient(
        colors: [Color(0xFF6A4C93), Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (name.contains('GigaChat')) {
      return const LinearGradient(
        colors: [Color(0xFF1F2937), Color(0xFF374151)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return const LinearGradient(
      colors: [Colors.blue, Colors.blueAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
