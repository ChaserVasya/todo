import 'package:todo/domain/models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAll();
  Future<void> add(Todo todo);
  Future<void> update(Todo todo);
  Future<Todo?> delete(String id);
}
