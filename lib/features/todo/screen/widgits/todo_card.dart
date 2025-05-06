import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/todo_model.dart';
import '../../provider/todo_provider.dart';

class TodoCard extends ConsumerWidget {
  final TodoModel todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: theme.brightness == Brightness.light
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ]
            : [],
      ),
      child: Row(
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => ref.read(toggleTodoProvider)(todo),
            activeColor: theme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              todo.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(
                  todo.isCompleted ? 0.5 : 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
