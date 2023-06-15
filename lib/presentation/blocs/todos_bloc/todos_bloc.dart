import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

part 'todos_bloc.freezed.dart';
part 'todos_event.dart';
part 'todos_state.dart';

@injectable
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository _repo;

  TodosBloc(this._repo) : super(const TodosState.initial()) {
    on<TodosEvent>(
      (event, emit) => event.map<Future<void>>(
        add: (event) => _add(event, emit),
        delete: (event) => _delete(event, emit),
        update: (event) => _update(event, emit),
        filter: (event) => _filter(event, emit),
        refresh: (_) => _refresh(emit),
      ),
      transformer: sequential(),
    );
    add(const TodosEvent.refresh());
  }

  Future<void> _add(_Add event, Emitter<TodosState> emit) async {
    await _repo.add(event.todo);
    await _refresh(emit);
  }

  Future<void> _delete(_Delete event, Emitter<TodosState> emit) async {
    await _repo.delete(event.id);
    await _refresh(emit);
  }

  Future<void> _update(_Update event, Emitter<TodosState> emit) async {
    await _repo.update(event.todo);
    await _refresh(emit);
  }

  Future<void> _refresh(Emitter<TodosState> emit) async {
    var todos = await _repo.getAll();

    if (state is _Main && (state as _Main).completedAreFiltered) {
      todos = todos.filter((e) => !e.completed).toList();
    }

    emit(TodosState.main(todos: todos));
  }

  Future<void> _filter(_Filter event, Emitter<TodosState> emit) async {
    final state = _ensureMain();
    emit(state.copyWith(
      completedAreFiltered: event.shouldFilter,
    ));
    add(const TodosEvent.refresh());
  }

  _Main _ensureMain() => state.mapOrNull(main: (state) => state)!;
}
