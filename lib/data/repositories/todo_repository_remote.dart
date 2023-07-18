import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/repositories/device_repository.dart';
import 'package:todo/data/services/todo_service/todo_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@prod
@dev
@lazySingleton
// @Named('remote')
// @LazySingleton(as: TodoRepository)
class TodoRepositoryRemote implements TodoRepository {
  final TodoService _service;
  final TodoMapper _mapper;
  final DeviceRepository _device;

  TodoRepositoryRemote(this._service, this._mapper, this._device);

  @override
  Future<void> add(Todo todo) async {
    logger.d('add to remote');
    await getAll();
    final dto = _mapper.toDto(todo);
    await _service.createTodo(
      dto.copyWith(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        changedAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdatedBy: (await _device.getId())!,
      ),
    );
  }

  @override
  Future<Todo?> delete(Id id) async {
    logger.d('delete from remote');
    await getAll();
    final dto = await _service.deleteTodo(id);
    return _mapper.fromDto(dto);
  }

  @override
  Future<List<Todo>> getAll() async {
    logger.d('get all from remote');
    final dtos = await _service.getTodos();
    return dtos.map(_mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
    logger.d('update remote');
    await getAll();
    await _service.updateTodo(
      todo.id!,
      _mapper.toDto(todo).copyWith(
            createdAt: DateTime.now().millisecondsSinceEpoch,
            changedAt: DateTime.now().millisecondsSinceEpoch,
            lastUpdatedBy: (await _device.getId())!,
          ),
    );
  }

  Future<List<Todo>> patch(List<Todo> todos) async {
    logger.d('patch remote');
    await getAll();
    final deviceId = (await _device.getId())!;
    final dtos = todos.map(_mapper.toDto).map((e) {
      return e.copyWith(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        changedAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdatedBy: deviceId,
      );
    }).toList();
    final merged = await _service.updateTodos(dtos);
    return merged.map(_mapper.fromDto).toList();
  }
}
