import 'package:flutter/material.dart';

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String avatarUrl;
  final bool isVerified;
  final int unreadCount;
  final bool isNew;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.avatarUrl,
    this.isVerified = false,
    this.unreadCount = 0,
    this.isNew = false,
  });

  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(lastMessageTime);

    if (difference.inDays > 0) {
      return '${lastMessageTime.day}/${lastMessageTime.month}';
    } else if (difference.inHours > 0) {
      return '${lastMessageTime.hour}:${lastMessageTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${lastMessageTime.hour}:${lastMessageTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String? avatarUrl;
  final bool isVerified;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatarUrl,
    this.isVerified = false,
  });
}
