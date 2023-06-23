part of 'todos_bloc.dart';

@freezed
class TodosState with _$TodosState {
  const factory TodosState.loading() = _Loading;
  const factory TodosState.main({
    required List<Todo> todos,
    @Default(false) bool shouldFilter,
  }) = _Main;
}
