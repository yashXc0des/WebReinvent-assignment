import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_model.dart';

class TodoRepository {
  final _todoRef = FirebaseFirestore.instance.collection('todos');

  Stream<List<TodoModel>> getTodos() {
    return _todoRef.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TodoModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addTodo(String title) async {
    await _todoRef.add({'title': title, 'isCompleted': false});
  }

  Future<void> toggleTodoStatus(TodoModel todo) async {
    await _todoRef.doc(todo.id).update({'isCompleted': !todo.isCompleted});
  }
}
