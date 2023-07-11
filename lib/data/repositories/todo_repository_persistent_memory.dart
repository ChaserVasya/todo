import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/storages/daos/todo_dao.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@Named('pers')
@prod
@dev
@LazySingleton(as: TodoRepository)
class TodoRepositoryPersistentMemory implements TodoRepository {
  TodoRepositoryPersistentMemory(this.dao, this.mapper);

  final TodoDao dao;
  final TodoMapper mapper;

  @override
  Future<void> add(Todo todo) {
    logger.d('local:add');
    return dao.insertTodo(mapper.toEntity(todo));
  }

  @override
  Future<Todo?> delete(String id) async {
    logger.d('local:delete');
    await dao.deleteTodo(id);
    return null;
  }

  @override
  Future<List<Todo>> getAll() async {
    logger.d('local:getAll');
    final dtos = await dao.findAllTodo();
    return dtos.map(mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
    logger.d('local:update');
    dao.updateTodo(mapper.toEntity(todo));
  }
}
