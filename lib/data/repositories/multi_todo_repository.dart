import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

class MultiTodoRepository implements TodoRepository {
  final TodoRepository _localRepo;
  final TodoRepository _remoteRepo;
  final InternetConnectionChecker _connectionChecker;
  bool _connectionLostedAtMostOnce = false;

  static const uuid = Uuid();

  MultiTodoRepository(
    this._localRepo,
    this._remoteRepo,
    this._connectionChecker,
  );

  Future<void> _checkConnect() async {
    if (_connectionLostedAtMostOnce) {
      return;
    }
    final res = await _connectionChecker.hasConnection;
    if (!res) {
      _connectionLostedAtMostOnce = true;
    }
  }

  Future<T> _doIfRemoteAllowed<T>(Future<T> Function() fn) async {
    await _checkConnect();
    if (!_connectionLostedAtMostOnce) {
      return fn();
    }
    return Future.value();
  }

  @override
  Future<void> add(Todo todo) {
    final id = uuid.v1();
    todo = todo.copyWith(id: id);
    return Future.wait([
      _localRepo.add(todo),
      _doIfRemoteAllowed(() => _remoteRepo.add(todo)),
    ]);
  }

  @override
  Future<Todo?> delete(String id) async {
    final res = await Future.wait([
      _localRepo.delete(id),
      _doIfRemoteAllowed(() => _remoteRepo.delete(id)),
    ]);
    return res.first;
  }

  @override
  Future<List<Todo>> getAll() {
    return _localRepo.getAll();
  }

  @override
  Future<void> update(Todo todo) {
    return Future.wait([
      _localRepo.update(todo),
      _doIfRemoteAllowed(() => _remoteRepo.update(todo)),
    ]);
  }
}
