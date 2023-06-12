import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

part 'todo_bloc.freezed.dart';
part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repo;

  TodoBloc(this._repo) : super(const TodoState.initial()) {
    on<TodoEvent>(
      (event, emit) => event.map<Future<void>>(
        add: (event) => _add(event, emit),
        delete: (event) => _delete(event, emit),
        update: (event) => _update(event, emit),
      ),
      transformer: sequential(),
    );
  }

  Future<void> _add(_Add event, Emitter<TodoState> emit) async {
    await _repo.add(event.todo);
    await _refresh(emit);
  }

  Future<void> _delete(_Delete event, Emitter<TodoState> emit) async {
    await _repo.delete(event.todo.id!);
    await _refresh(emit);
  }

  Future<void> _update(_Update event, Emitter<TodoState> emit) async {
    await _repo.update(event.todo);
    await _refresh(emit);
  }

  Future<void> _refresh(Emitter<TodoState> emit) async {
    final todos = await _repo.getAll();
    emit(TodoState.main(todos));
  }
}
