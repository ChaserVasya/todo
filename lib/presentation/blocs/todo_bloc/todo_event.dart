part of 'todo_bloc.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.add(Todo todo) = _Add;
  const factory TodoEvent.delete(Todo todo) = _Delete;
  const factory TodoEvent.update(Todo todo) = _Update;
}
