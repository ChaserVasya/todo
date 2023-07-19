import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
import 'package:todo/domain/models/todo.dart';

@lazySingleton
class TodoRepositoryLogger implements TodoRepositoryRemote {
  const TodoRepositoryLogger(this._repo, this._logger);

  final TodoRepositoryRemote _repo;
  final Logger _logger;

  @override
  Future<void> add(Todo todo) async {
    await _repo.add(todo);
    _logger.i('add');
  }

  @override
  Future<Todo?> delete(String id) async {
    final res = await _repo.delete(id);
    _logger.i('delete');
    return res;
  }

  @override
  Future<List<Todo>> getAll() async {
    final res = await _repo.getAll();
    _logger.i('getAll');
    return res;
  }

  @override
  Future<void> update(Todo todo) async {
    await _repo.update(todo);
    _logger.i('update');
  }

  @override
  Future<List<Todo>> patch(List<Todo> todos) async {
    final res = await _repo.patch(todos);
    _logger.i('patch');
    return res;
  }
}
