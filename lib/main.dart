import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Добавляем обработку ошибок
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  
  runApp(const SimpleChatApp());
}

class SimpleChatApp extends StatelessWidget {
  const SimpleChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чаты',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SimpleMainScreen(),
    );
  }
}

class SimpleMainScreen extends StatefulWidget {
  const SimpleMainScreen({super.key});

  @override
  State<SimpleMainScreen> createState() => _SimpleMainScreenState();
}

class _SimpleMainScreenState extends State<SimpleMainScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Чаты'),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Контакты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Звонки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const Center(
          child: Text(
            'Контакты',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        );
      case 1:
        return const Center(
          child: Text(
            'Звонки',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        );
      case 2:
        return _buildChatsScreen();
      case 3:
        return const Center(
          child: Text(
            'Настройки',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        );
      default:
        return const Center(
          child: Text(
            'Ошибка',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        );
    }
  }

  Widget _buildChatsScreen() {
    return Column(
      children: [
        // Простая карточка
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('M', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAX',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Вход с нового устройства...',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Вторая карточка
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text('G', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GigaChat • MAX',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Вот что я умею...',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
