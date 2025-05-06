import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/todo_repository.dart';
import '../model/todo_model.dart';

final todoRepoProvider = Provider((ref) => TodoRepository());

final todoListProvider = StreamProvider<List<TodoModel>>((ref) {
  return ref.watch(todoRepoProvider).getTodos();
});

final addTodoProvider = Provider((ref) => ref.watch(todoRepoProvider).addTodo);
final toggleTodoProvider = Provider((ref) => ref.watch(todoRepoProvider).toggleTodoStatus);
