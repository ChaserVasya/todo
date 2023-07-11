import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo/data/entities/todo/todo_entity.dart';
import 'package:todo/data/storages/daos/todo_dao.dart';

part 'db.g.dart';

@Database(version: 1, entities: [TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
