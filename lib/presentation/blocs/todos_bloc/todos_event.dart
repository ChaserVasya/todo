part of 'todos_bloc.dart';

@freezed
class TodosEvent with _$TodosEvent {
  const factory TodosEvent.add(Todo todo) = _Add;
  const factory TodosEvent.delete(int id) = _Delete;
  const factory TodosEvent.update(Todo todo) = _Update;
  const factory TodosEvent.refresh() = _Refresh;
  const factory TodosEvent.filter({required bool shouldFilter}) = _Filter;
}
