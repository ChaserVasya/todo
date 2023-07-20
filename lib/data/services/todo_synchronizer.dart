import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo/data/repositories/todo_repo_logger.dart';
import 'package:todo/data/repositories/todo_repository_persistent_memory.dart';
import 'package:todo/domain/models/todo.dart';

@prod
@dev
@lazySingleton
class TodoSynchronizer {
  final TodoRepositoryPersistentMemory _localRepo;
  final TodoRepositoryLogger _remoteRepo;
  final Logger _logger;

  TodoSynchronizer(
    this._localRepo,
    this._remoteRepo,
    this._logger,
  );

  Future<void> synchronize() async {
    _logger.d('synchronizing');
    final remoteRepo = _remoteRepo;
    final localTodos = await _localRepo.getAll();
    try {
      final remoteTodos = await remoteRepo.getAll();
      final merged = _mergeWithOfflineFirst(localTodos, remoteTodos);
      await Future.wait(
        [for (final todo in merged) _localRepo.add(todo)],
      );
      await remoteRepo.patch(merged);
      _logger.d('synchronized');
    } catch (e) {
      _logger.d('not synchronized');
    }
  }

  List<Todo> _mergeWithOfflineFirst(List<Todo> offline, List<Todo> online) {
    return {
      for (final todo in online) todo.id!: todo,
      for (final todo in offline) todo.id!: todo,
    }.values.toList();
  }
}
