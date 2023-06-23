import 'package:injectable/injectable.dart';
import 'package:todo/data/dtos/todo_dto/todo_dto.dart';
import 'package:todo/domain/models/todo.dart';

@singleton
class TodoMapper {
  Todo fromDto(TodoDto dto) {
    return Todo(
      id: dto.id,
      todo: dto.text,
      completed: dto.done,
      deadline: dto.deadline != null
          ? DateTime.fromMillisecondsSinceEpoch(dto.deadline!)
          : null,
      priority: _importanceFromDto[dto.importance]!,
    );
  }

  TodoDto toDto(Todo todo) {
    return TodoDto(
      id: todo.id,
      text: todo.todo,
      done: todo.completed,
      importance: _importanceToDto[todo.priority]!,
      deadline: todo.deadline?.millisecondsSinceEpoch,
    );
  }
}

const _importanceFromDto = {
  'low': Priority.low,
  'basic': Priority.none,
  'important': Priority.high,
};

final _importanceToDto = _importanceFromDto.map(
  (key, value) => MapEntry(value, key),
);
