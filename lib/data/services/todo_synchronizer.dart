import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@prod
@dev
@lazySingleton
class TodoSynchronizer {
  final TodoRepository _localRepo;
  final TodoRepository _remoteRepo;

  TodoSynchronizer(
    @Named('pers') this._localRepo,
    @Named('remote') this._remoteRepo,
  );

  Future<void> synchronize() async {
    logger.d('synchronizing');
    final remoteRepo = _remoteRepo as TodoRepositoryRemote;
    final localTodos = await _localRepo.getAll();
    try {
      final remoteTodos = await remoteRepo.getAll();
      final merged = _mergeWithOfflineFirst(localTodos, remoteTodos);
      await Future.wait(
        [for (final todo in merged) _localRepo.add(todo)],
      );
      await remoteRepo.patch(merged);
      logger.d('synchronized');
    } catch (e) {
      logger.d('not synchronized');
    }
  }

  List<Todo> _mergeWithOfflineFirst(List<Todo> offline, List<Todo> online) {
    return {
      for (final todo in online) todo.id!: todo,
      for (final todo in offline) todo.id!: todo,
    }.values.toList();
  }
}
