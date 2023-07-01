import 'package:injectable/injectable.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/repositories/device_repository.dart';
import 'package:todo/data/services/todo_service/todo_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryRemote implements TodoRepository {
  final TodoService service;
  final TodoMapper mapper;
  final DeviceRepository device;

  static const uuid = Uuid();

  TodoRepositoryRemote(this.service, this.mapper, this.device);

  @override
  Future<void> add(Todo todo) async {
    await getAll();
    final id = uuid.v1();
    final dto = mapper.toDto(todo.copyWith(id: id));
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
    await getAll();
    final dto = await service.deleteTodo(id);
    return mapper.fromDto(dto);
  }

  @override
  Future<List<Todo>> getAll() async {
    final dtos = await service.getTodos();
    return dtos.map(mapper.fromDto).toList();
  }

  @override
  Future<void> update(Todo todo) async {
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
}
