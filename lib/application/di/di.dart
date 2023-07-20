import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/application/exceptions/handle_exceptions.dart';
import 'package:todo/data/repositories/multi_todo_repository.dart';
import 'package:todo/data/repositories/todo_repo_logger.dart';
import 'package:todo/data/repositories/todo_repository_persistent_memory.dart';
import 'package:todo/data/repositories/todo_repository_temp_memory.dart';
import 'package:todo/data/services/dio.dart';
import 'package:todo/data/storages/daos/todo_dao.dart';
import 'package:todo/data/storages/db/db.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/firebase_options.dart';
import 'package:uuid/uuid.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(String env) async {
  await getIt.init(environment: env);
  handleExceptions();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createYandexClient();

  @prod
  @dev
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @prod
  @dev
  @preResolve
  @singleton
  Future<AppDatabase> get db =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();

  @prod
  @dev
  @lazySingleton
  TodoDao todoDao(AppDatabase db) => db.todoDao;

  @lazySingleton
  DeviceInfoPlugin get device => DeviceInfoPlugin();

  @prod
  @dev
  @lazySingleton
  InternetConnectionChecker get checker => InternetConnectionChecker();

  @lazySingleton
  Uuid get uuid => const Uuid();

  @test
  @LazySingleton(as: TodoRepository)
  TodoRepositoryTempMemory testRepo(Logger _logger, Uuid uuid) {
    return TodoRepositoryTempMemory(_logger, uuid);
  }

  @prod
  @dev
  @LazySingleton(as: TodoRepository)
  MultiTodoRepository multi(
    TodoRepositoryPersistentMemory pers,
    TodoRepositoryLogger remote,
    InternetConnectionChecker checker,
  ) {
    return MultiTodoRepository(
      pers,
      remote,
      checker,
    );
  }

  @preResolve
  @singleton
  Future<FirebaseApp> get firebase => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  @lazySingleton
  FirebaseRemoteConfig remoteConfig(FirebaseApp app) =>
      FirebaseRemoteConfig.instance;

  @lazySingleton
  FirebaseAnalytics analytics(FirebaseApp app) => FirebaseAnalytics.instance;

  @lazySingleton
  FirebaseCrashlytics crashlytics(FirebaseApp app) =>
      FirebaseCrashlytics.instance;

  @test
  @lazySingleton
  Logger logger() => Logger();

  @Named('logger')
  @prod
  @dev
  @lazySingleton
  Logger baseLogger() => Logger();
}
