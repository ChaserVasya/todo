import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/services/dio.dart';
import 'package:todo/data/storages/daos/todo_dao.dart';
import 'package:todo/data/storages/db/db.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(String env) async {
  await getIt.init(environment: env);
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createYandexClient();

  @prod
  @dev
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @prod
  @dev
  @preResolve
  Future<AppDatabase> get db =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();

  @prod
  @dev
  @lazySingleton
  TodoDao todoDao(AppDatabase db) => db.todoDao;

  DeviceInfoPlugin get device => DeviceInfoPlugin();

  @prod
  @dev
  @lazySingleton
  InternetConnectionChecker get checker => InternetConnectionChecker();
}
