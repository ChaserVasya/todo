import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/repositories/device_repository.dart';
import 'package:todo/data/services/todo_service/todo_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

@Named('remote')
@prod
@dev
@LazySingleton(as: TodoRepository)
class TodoRepositoryRemote implements TodoRepository {
  final TodoService service;
  final TodoMapper mapper;
  final DeviceRepository device;

  TodoRepositoryRemote(this.service, this.mapper, this.device);

  @override
  Future<void> add(Todo todo) async {
    logger.d('add to remote');
    await getAll();
    final dto = mapper.toDto(todo);
    await service.createTodo(
      dto.copyWith(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        changedAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdatedBy: (await device.getId())!,
      ),
    );
  }

  @override
  Future<Todo?> delete(Id id) async {
    logger.d('delete from remote');
    await getAll();
    final dto = await service.deleteTodo(id);
    return mapper.fromDto(dto);
  }

  @override
  Future<List<Todo>> getAll() async {
    logger.d('get all from remote');
    final dtos = await service.getTodos();
    return dtos.map(mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
    logger.d('update remote');
    await getAll();
    await service.updateTodo(
      todo.id!,
      mapper.toDto(todo).copyWith(
            createdAt: DateTime.now().millisecondsSinceEpoch,
            changedAt: DateTime.now().millisecondsSinceEpoch,
            lastUpdatedBy: (await device.getId())!,
          ),
    );
  }

  Future<List<Todo>> patch(List<Todo> todos) async {
    logger.d('patch remote');
    await getAll();
    final deviceId = (await device.getId())!;
    final dtos = todos.map(mapper.toDto).map((e) {
      return e.copyWith(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        changedAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdatedBy: deviceId,
      );
    }).toList();
    final merged = await service.updateTodos(dtos);
    return merged.map(mapper.fromDto).toList();
  }
}
