import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/todo_model.dart';
import '../../provider/todo_provider.dart';

class TodoCard extends ConsumerWidget {
  final TodoModel todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Custom checkbox
          GestureDetector(
            onTap: () => ref.read(toggleTodoProvider)(todo),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: todo.isCompleted
                    ? const Color(0xFF007AFF)
                    : isDarkMode
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFE5E5EA),
                border: todo.isCompleted
                    ? null
                    : Border.all(
                  color: isDarkMode
                      ? Colors.grey.shade600
                      : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: todo.isCompleted
                  ? const Icon(
                CupertinoIcons.checkmark,
                size: 16,
                color: Colors.white,
              )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Task title
          Expanded(
            child: Text(
              todo.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                todo.isCompleted ? FontWeight.normal : FontWeight.w500,
                decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(
                  todo.isCompleted ? 0.6 : 1,
                ),
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Delete icon with visible constraints
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final confirm = await showCupertinoDialog<bool>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Delete Task'),
                  content:
                  const Text('Are you sure you want to delete this task?'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(deleteTodoProvider)(todo.id);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.delete_solid,
                color: isDarkMode
                    ? Colors.redAccent.shade100
                    : Colors.redAccent,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
