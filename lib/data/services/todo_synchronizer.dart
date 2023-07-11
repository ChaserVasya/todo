import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
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
      // Если пусто (ток установили) - грузим с сервера
      if (localTodos.isEmpty) {
        final remoteTodos = await remoteRepo.getAll();
        for (final todo in remoteTodos) {
          await _localRepo.add(todo);
        }
      } else {
        await remoteRepo.patch(localTodos);
      }
      logger.d('synchronized');
    } catch (e) {
      logger.d('not synchronized');
    }
  }
}
