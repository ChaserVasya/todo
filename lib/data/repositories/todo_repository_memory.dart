import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

typedef Id = int;

@Singleton(as: TodoRepository)
class TodoRepositoryMemory implements TodoRepository {
  final Map<Id, Todo> todos = SplayTreeMap.fromIterables(
    _stub.map((e) => e.id!),
    _stub,
    (key1, key2) => key1.compareTo(key2),
  );

  @override
  Future<void> add(Todo todo) async {
    if (todo.id != null) return;

    final newId = genId();
    todos[newId] = todo.copyWith(id: newId);
  }

  @override
  Future<void> update(Todo todo) async {
    if (todo.id == null) return;
    todos[todo.id!] = todo;
  }

  @override
  Future<Todo?> delete(int id) async {
    return todos.remove(id);
  }

  @override
  Future<List<Todo>> getAll() async {
    return todos.values.toList();
  }

  int genId() => todos.keys.last + 1;
}

final _stub = () {
  final stub = [
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то',
    ),
    const Todo(
      todo: 'Купить что-то где-то, зачем-то, но зачем не очень понятно',
    ),
    const Todo(
      todo: 'Купить что-то где-то, зачем-то, но зачем не очень понятно, но '
          'точно, чтоб показать как обрезается текст, если он больше трёх '
          'строчек',
    ),
    const Todo(
      todo: 'Купить что-то',
      priority: Priority.high,
    ),
    const Todo(
      todo: 'Купить что-то',
      priority: Priority.low,
    ),
    Todo(
      todo: 'Купить что-то',
      dateTime: DateTime.now(),
    ),
  ];
  return [
    for (var i = 0; i < stub.length; i++) //
      stub[i].copyWith(id: i),
  ];
}();
