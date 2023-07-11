import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/storages/rev_local_storage.dart';
import 'package:todo/domain/repositories/revision_repository.dart';

import 'revision_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late RevisionRepository revRepo;
  late MockSharedPreferences mock;

  setUp(() {
    mock = MockSharedPreferences();
    revRepo = RevLocalStorage(mock);
  });

  test('Геттер возращает null если ревизия не была инициализирована', () {
    const err = 'Нет значения';
    when(mock.getInt(any)).thenThrow(err);
    expect(revRepo.get(), null);
  });

  test('Геттер возращает значение, если ревизия была установлена', () {
    const ans = 1;
    when(mock.getInt(any)).thenReturn(ans);
    expect(revRepo.get(), ans);
  });
}
