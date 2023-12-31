import 'package:injectable/injectable.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/repositories/device_repository.dart';
import 'package:todo/data/services/todo_service/todo_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@lazySingleton
class TodoRepositoryRemote implements TodoRepository {
  final TodoService _service;
  final TodoMapper _mapper;
  final DeviceRepository _device;

  TodoRepositoryRemote(this._service, this._mapper, this._device);

  @override
  Future<void> add(Todo todo) async {
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
    await getAll();
    final dto = await _service.deleteTodo(id);
    return _mapper.fromDto(dto);
  }

  @override
  Future<List<Todo>> getAll() async {
    final dtos = await _service.getTodos();
    return dtos.map(_mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
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
