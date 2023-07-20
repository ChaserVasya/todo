import 'package:floor/floor.dart';
import 'package:todo/data/entities/todo/todo_entity.dart';
import 'package:todo/domain/models/todo.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM TodoEntity')
  Future<List<TodoEntity>> findAllTodo();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(TodoEntity todo);

  @Query('DELETE FROM TodoEntity WHERE id=:id')
  Future<void> deleteTodo(Id id);

  @Query('DELETE FROM TodoEntity')
  Future<void> deleteAll();

  @update
  Future<void> updateTodo(TodoEntity todo);
}
