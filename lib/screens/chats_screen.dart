import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../widgets/chat_card.dart';
import '../widgets/connect_contacts_card.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTab = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index == 0 ? 'all' : 'new';
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Chat> get _chats {
    return [
      Chat(
        id: '1',
        name: 'MAX',
        lastMessage: 'Вход с нового устройства В ваш профиль MAX вошли с нового у...',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 12)),
        avatarUrl: '',
        isVerified: true,
        unreadCount: 1,
      ),
      Chat(
        id: '2',
        name: 'GigaChat • MAX',
        lastMessage: 'Вот что я умею: [image icon] Создавать изображения: от аватарки до открытки н...',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 33)),
        avatarUrl: '',
        isVerified: true,
        unreadCount: 0,
      ),
    ];
  }

  List<Chat> get _filteredChats {
    if (_selectedTab == 'new') {
      return _chats.where((chat) => chat.isNew).toList();
    }
    return _chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Чаты',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Поиск
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Добавить чат
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          tabs: [
            const Tab(text: 'Все'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Новые'),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Карточка подключения контактов
          const ConnectContactsCard(),
          
          // Список чатов
          Expanded(
            child: _filteredChats.isEmpty
                ? const Center(
                    child: Text(
                      'Нет чатов',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return ChatCard(chat: chat);
                    },
                  ),
          ),
          
          // Ссылки внизу
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildActionLink(
                  icon: Icons.link,
                  text: 'Пригласить по ссылке',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildActionLink(
                  icon: Icons.qr_code,
                  text: 'Пригласить по QR-коду',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildActionLink(
                  icon: Icons.phone,
                  text: 'Найти по номеру',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionLink({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
