import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/theme_provider.dart';
import '../provider/todo_provider.dart';
import 'widgits/todo_card.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
        final backgroundColor = isDarkMode
            ? const Color(0xFF1C1C1E)
            : Colors.white;
        final textColor = isDarkMode
            ? Colors.white
            : const Color(0xFF1C1C1E);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.xmark_circle_fill,
                        color: Colors.grey.withOpacity(0.5),
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _titleController.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF2C2C2E)
                        : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _titleController,
                    autofocus: true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Task name',
                      hintStyle: TextStyle(
                        color: textColor.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: const Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    onPressed: () {
                      if (_titleController.text.trim().isNotEmpty) {
                        ref.read(addTodoProvider)(_titleController.text.trim());
                        _titleController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Add Task',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoListProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final backgroundColor = isDarkMode
        ? const Color(0xFF000000)
        : const Color(0xFFF2F2F7);
    final textColor = isDarkMode
        ? Colors.white
        : const Color(0xFF000000);
    final secondaryTextColor = isDarkMode
        ? Colors.grey[400]
        : Colors.grey[600];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        elevation: 0,
        title: Text(
          'Tasks',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode
                  ? CupertinoIcons.sun_max_fill
                  : CupertinoIcons.moon_fill,
              color: isDarkMode
                  ? Colors.white
                  : Colors.black,
              size: 22,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
              isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: todosAsync.when(
          data: (todos) => todos.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.checkmark_circle,
                  size: 64,
                  color: secondaryTextColor,
                ),
                const SizedBox(height: 16),
                Text(
                  "No Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap + to add a new task",
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              // Removed the Container wrapper to avoid conflicting with TodoCard's own styling
              child: TodoCard(todo: todos[index]),
            ),
          ),
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
          error: (e, _) => Center(
            child: Text(
              "Error: $e",
              style: TextStyle(color: Colors.red[400]),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF007AFF).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddTaskSheet,
          backgroundColor: Colors.transparent,
          elevation: 0,
          tooltip: 'Add Task',
          child: const Icon(
            CupertinoIcons.add,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}