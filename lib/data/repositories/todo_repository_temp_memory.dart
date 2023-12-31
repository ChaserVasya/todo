import 'dart:collection';

import 'package:logger/logger.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoRepositoryTempMemory implements TodoRepository {
  TodoRepositoryTempMemory(this._logger, this.uuid);

  final Logger _logger;
  final Uuid uuid;

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

    _logger.d('$todo');
  }

  @override
  Future<void> update(Todo todo) async {
    if (todo.id == null) return;
    todos[todo.id!] = todo;

    _logger.d('$todo');
  }

  @override
  Future<Todo?> delete(Id id) async {
    _logger.d(id);

    return todos.remove(id);
  }

  @override
  Future<List<Todo>> getAll() async {
    return todos.values.toList();
  }

  Id genId() => uuid.v1();
}

final _stub = () {
  final stub = [
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
      deadline: DateTime.now(),
    ),
  ];
  const uuid = Uuid();
  return [
    for (var i = 0; i < stub.length; i++) //
      stub[i].copyWith(id: uuid.v1()),
  ];
}();
