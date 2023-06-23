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

  TodosBloc(this._repo) : super(const TodosState.loading()) {
    on<TodosEvent>(
      (event, emit) => event.map<Future<void>>(
        add: (event) => _add(event, emit),
        delete: (event) => _delete(event, emit),
        update: (event) => _update(event, emit),
        filter: (event) => _filter(event, emit),
        init: (_) => _init(emit),
      ),
      transformer: sequential(),
    );
    add(const TodosEvent.init());
  }

  Future<void> _add(_Add event, Emitter<TodosState> emit) async {
    final main = _ensureMain();
    emit(const TodosState.loading());
    await _repo.add(event.todo);
    await _refresh(emit, main);
  }

  Future<void> _delete(_Delete event, Emitter<TodosState> emit) async {
    final main = _ensureMain();
    emit(const TodosState.loading());
    await _repo.delete(event.id);
    await _refresh(emit, main);
  }

  Future<void> _update(_Update event, Emitter<TodosState> emit) async {
    final main = _ensureMain();
    emit(const TodosState.loading());
    await _repo.update(event.todo);
    await _refresh(emit, main);
  }

  Future<void> _refresh(Emitter<TodosState> emit, _Main oldState) async {
    var todos = await _repo.getAll();
    emit(oldState.copyWith(todos: todos));
  }

  Future<void> _init(Emitter<TodosState> emit) async {
    var todos = await _repo.getAll();
    emit(TodosState.main(
      todos: todos,
    ));
  }

  Future<void> _filter(_Filter event, Emitter<TodosState> emit) async {
    final state = _ensureMain();
    emit(state.copyWith(shouldFilter: event.shouldFilter));
  }

  _Main _ensureMain() => state.mapOrNull(main: (state) => state)!;
}
