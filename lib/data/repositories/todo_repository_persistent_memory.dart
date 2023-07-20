import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/storages/daos/todo_dao.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@lazySingleton
class TodoRepositoryPersistentMemory implements TodoRepository {
  TodoRepositoryPersistentMemory(this._dao, this._mapper, this._logger);

  final TodoDao _dao;
  final TodoMapper _mapper;
  final Logger _logger;

  @override
  Future<void> add(Todo todo) {
    _logger.d('local:add');
    return _dao.insertTodo(_mapper.toEntity(todo));
  }

  @override
  Future<Todo?> delete(String id) async {
    _logger.d('local:delete');
    await _dao.deleteTodo(id);
    return null;
  }

  @override
  Future<List<Todo>> getAll() async {
    _logger.d('local:getAll');
    final dtos = await _dao.findAllTodo();
    return dtos.map(_mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
    _logger.d('local:update');
    _dao.updateTodo(_mapper.toEntity(todo));
  }
}
