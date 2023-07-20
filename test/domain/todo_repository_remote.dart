import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/data/dtos/todo_dto/todo_dto.dart';
import 'package:todo/data/mappers/todo_mapper.dart';
import 'package:todo/data/repositories/device_repository.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
import 'package:todo/data/services/todo_service/todo_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

import 'todo_repository_remote.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TodoService>(),
  MockSpec<TodoMapper>(),
  MockSpec<DeviceRepository>(),
])
void main() {
  late TodoRepository repo;
  late MockDeviceRepository deviceRepoMock;
  late MockTodoMapper mapperMock;
  late MockTodoService serviceMock;

  setUp(() {
    deviceRepoMock = MockDeviceRepository();
    mapperMock = MockTodoMapper();
    serviceMock = MockTodoService();
    when(deviceRepoMock.getId()).thenAnswer((_) => Future.value(''));
    when(mapperMock.toDto(any)).thenAnswer((_) => const TodoDto(
          text: '',
          done: true,
          importance: '',
        ));

    repo = TodoRepositoryRemote(
      serviceMock,
      mapperMock,
      deviceRepoMock,
    );
  });

  group('CRUD-методы работают корректно', () {
    test('При создании генерируется uuid', () async {
      var todo = const Todo();
      await repo.add(todo);
      final dto = verify(
        serviceMock.createTodo(captureAny),
      ).captured.single as TodoDto;
      expect(dto.id, isNotNull);
    });
    test('При создании ставится время создания и изменения', () async {
      var todo = const Todo();
      await repo.add(todo);
      final dto = verify(
        serviceMock.createTodo(captureAny),
      ).captured.single as TodoDto;
      expect(dto.createdAt, isNotNull);
      expect(dto.changedAt, isNotNull);
    });
  });
}
