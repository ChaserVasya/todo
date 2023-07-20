import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

typedef Id = String;

@freezed
class Todo with _$Todo {
  const Todo._();

  const factory Todo({
    Id? id,
    @Default('') String todo,
    DateTime? deadline,
    @Default(Priority.none) Priority priority,
    @Default(false) bool completed,
  }) = _Todo;

  bool get alreadyCreated => id != null;
}

enum Priority {
  none,
  low,
  high,
}
