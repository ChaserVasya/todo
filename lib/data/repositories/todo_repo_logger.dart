import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@Named('remote')
@LazySingleton(as: TodoRepository)
class TodoRepositoryLogger implements TodoRepositoryRemote {
  final TodoRepositoryRemote _repo;
  final FirebaseAnalytics _logger;

  TodoRepositoryLogger(this._repo, this._logger);

  @override
  Future<void> add(Todo todo) async {
    await _repo.add(todo);
    await _logger.logEvent(name: 'add');
  }

  @override
  Future<Todo?> delete(String id) async {
    final res = await _repo.delete(id);
    await _logger.logEvent(name: 'delete');
    return res;
  }

  @override
  Future<List<Todo>> getAll() async {
    final res = await _repo.getAll();
    await _logger.logEvent(name: 'getAll');
    return res;
  }

  @override
  Future<void> update(Todo todo) async {
    await _repo.update(todo);
    await _logger.logEvent(name: 'update');
  }

  @override
  Future<List<Todo>> patch(List<Todo> todos) async {
    final res = await _repo.patch(todos);
    await _logger.logEvent(name: 'patch');
    return res;
  }
}
