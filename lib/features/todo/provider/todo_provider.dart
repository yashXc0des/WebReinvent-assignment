import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/todo_repository.dart';
import '../model/todo_model.dart';


// Provide the repository
final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository();
});

// Provider for deleting todo
final deleteTodoProvider = Provider<Future<void> Function(String)>((ref) {
  final repo = ref.read(todoRepositoryProvider);
  return (String id) async {
    await repo.deleteTodo(id);
  };
});

final todoRepoProvider = Provider((ref) => TodoRepository());

final todoListProvider = StreamProvider<List<TodoModel>>((ref) {
  return ref.watch(todoRepoProvider).getTodos();
});

final addTodoProvider = Provider((ref) => ref.watch(todoRepoProvider).addTodo);
final toggleTodoProvider = Provider((ref) => ref.watch(todoRepoProvider).toggleTodoStatus);
