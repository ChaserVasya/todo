part of 'todo_editing_cubit.dart';

@freezed
class TodoEditingState with _$TodoEditingState {
  const factory TodoEditingState.editing({
    int? id,
    required String todo,
    DateTime? deadline,
    required Priority priority,
    required bool completed,
  }) = _Editing;
  const factory TodoEditingState.completed(Todo todo) = _Completed;
}
