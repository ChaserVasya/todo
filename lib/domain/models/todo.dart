import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String todo,
    DateTime? dateTime,
    @Default(Priority.none) Priority priority,
    @Default(false) bool completed,
  }) = _Todo;
}

enum Priority {
  none,
  low,
  high,
}
