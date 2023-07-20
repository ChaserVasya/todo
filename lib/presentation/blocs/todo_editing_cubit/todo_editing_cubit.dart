import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/domain/models/todo.dart';

part 'todo_editing_cubit.freezed.dart';
part 'todo_editing_state.dart';

@injectable
class TodoEditingCubit extends Cubit<TodoEditingState> {
  @factoryMethod
  TodoEditingCubit(@factoryParam Todo? todo)
      : super(TodoEditingState.editing(
          id: todo?.id,
          todo: todo?.todo ?? '',
          priority: todo?.priority ?? Priority.none,
          completed: todo?.completed ?? false,
          deadline: todo?.deadline,
        ));

  void editDeadline(DateTime? deadline) {
    final state = _ensureEditingState();
    emit(state.copyWith(deadline: deadline));
  }

  void editPriority(Priority priority) {
    final state = _ensureEditingState();
    emit(state.copyWith(priority: priority));
  }

  void editCompleted(bool completed) {
    final state = _ensureEditingState();
    emit(state.copyWith(completed: completed));
  }

  void editTodo(String todo) {
    final state = _ensureEditingState();
    emit(state.copyWith(todo: todo));
  }

  void completeEditing() {
    final state = _ensureEditingState();
    emit(TodoEditingState.completed(Todo(
      id: state.id,
      todo: state.todo,
      deadline: state.deadline,
      completed: state.completed,
      priority: state.priority,
    )));
  }

  _Editing _ensureEditingState() {
    return state as _Editing;
  }
}
