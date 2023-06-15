part of 'todos_bloc.dart';

@freezed
class TodosState with _$TodosState {
  const factory TodosState.initial() = _Initial;
  const factory TodosState.main({
    required List<Todo> todos,
    @Default(false) bool completedAreFiltered,
  }) = _Main;
}
