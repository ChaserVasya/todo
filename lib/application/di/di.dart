import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/services/dio.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  // Intl.systemLocale = await findSystemLocale();
  // await initializeDateFormatting();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createYandexClient();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  DeviceInfoPlugin get device => DeviceInfoPlugin();
}
