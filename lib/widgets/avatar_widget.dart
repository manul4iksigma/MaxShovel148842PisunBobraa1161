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
        image: DecorationImage(
          image: AssetImage(_getAvatarImage()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _getAvatarImage() {
    if (name.contains('MAX') && !name.contains('GigaChat')) {
      return 'assets/images/max_avatar.png';
    } else if (name.contains('GigaChat')) {
      return 'assets/images/gigachat_avatar.png';
    }
    return 'assets/images/default_avatar.png';
  }
}
