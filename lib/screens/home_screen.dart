import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  String filter = 'all'; // all, completed, pending

  @override
  void initState() {
    super.initState();
    _loadSampleTasks();
  }

  void _loadSampleTasks() {
    tasks = [
      Task(
        id: '1',
        title: 'Изучить Flutter',
        description: 'Изучить основы Flutter и Dart для разработки мобильных приложений',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        priority: Priority.high,
      ),
      Task(
        id: '2',
        title: 'Создать дизайн приложения',
        description: 'Разработать UI/UX дизайн для нового приложения',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        dueDate: DateTime.now().add(const Duration(days: 3)),
        priority: Priority.medium,
        isCompleted: true,
      ),
      Task(
        id: '3',
        title: 'Написать документацию',
        description: 'Создать техническую документацию для проекта',
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 5)),
        priority: Priority.low,
      ),
    ];
  }

  List<Task> get filteredTasks {
    switch (filter) {
      case 'completed':
        return tasks.where((task) => task.isCompleted).toList();
      case 'pending':
        return tasks.where((task) => !task.isCompleted).toList();
      default:
        return tasks;
    }
  }

  void _toggleTaskCompletion(String taskId) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        tasks[taskIndex] = tasks[taskIndex].copyWith(
          isCompleted: !tasks[taskIndex].isCompleted,
        );
      }
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои задачи'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('Все задачи'),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Text('Активные'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Завершенные'),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
      body: filteredTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Нет задач',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Нажмите + чтобы добавить новую задачу',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return TaskCard(
                  task: task,
                  onToggle: () => _toggleTaskCompletion(task.id),
                  onDelete: () => _deleteTask(task.id),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/task_detail',
                      arguments: task,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
