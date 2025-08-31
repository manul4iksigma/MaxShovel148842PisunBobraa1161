import 'package:flutter/material.dart';
import '../models/chat.dart';
import 'avatar_widget.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;

  const ChatCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildAvatar(),
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        trailing: _buildTrailing(),
        onTap: () {
          // Открыть чат
        },
      ),
    );
  }

  Widget _buildAvatar() {
    return AvatarWidget(name: chat.name);
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                chat.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (chat.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    if (chat.name.contains('GigaChat') && chat.lastMessage.contains('[image icon]')) {
      // Для GigaChat показываем иконку вместо текста [image icon]
      final parts = chat.lastMessage.split('[image icon]');
      return Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(text: parts[0]),
                  WidgetSpan(
                    child: Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF4CAF50), // Зеленый
                            Color(0xFF81C784), // Светло-зеленый
                          ],
                        ),
                      ),
                      child: CustomPaint(
                        painter: _ImageIconPainter(),
                      ),
                    ),
                  ),
                  if (parts.length > 1) TextSpan(text: parts[1]),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
    
    return Text(
      chat.lastMessage,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          chat.formattedTime,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        if (chat.unreadCount > 0) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            child: Text(
              chat.unreadCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  
}

class _ImageIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Рисуем простой пейзаж: небо, горы, поле
    final skyPaint = Paint()
      ..color = const Color(0xFF87CEEB) // Голубое небо
      ..style = PaintingStyle.fill;
    
    final mountainPaint = Paint()
      ..color = const Color(0xFFD3D3D3) // Светло-серые горы
      ..style = PaintingStyle.fill;
    
    final fieldPaint = Paint()
      ..color = const Color(0xFF90EE90) // Зеленое поле
      ..style = PaintingStyle.fill;

    // Небо (верхняя часть)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.6),
      skyPaint,
    );

    // Горы (средняя часть)
    final mountainPath = Path();
    mountainPath.moveTo(0, size.height * 0.6);
    mountainPath.lineTo(size.width * 0.3, size.height * 0.3);
    mountainPath.lineTo(size.width * 0.7, size.height * 0.4);
    mountainPath.lineTo(size.width, size.height * 0.5);
    mountainPath.lineTo(size.width, size.height * 0.6);
    mountainPath.close();
    canvas.drawPath(mountainPath, mountainPaint);

    // Поле (нижняя часть)
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4),
      fieldPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
