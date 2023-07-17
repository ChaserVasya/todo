import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/application/global.dart';
import 'package:todo/presentation/uikit/theme.dart';

@lazySingleton
class ImportanceColorCubit extends Cubit<Color> {
  final FirebaseRemoteConfig _remote;

  static const _initColor = ColorsUI.red;
  static const _colorField = 'importanceColor';

  ImportanceColorCubit(this._remote) : super(_initColor) {
    _init();
  }

  void _init() async {
    try {
      await _remote.ensureInitialized();
      await _remote.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await _remote.fetchAndActivate();
      emit(HexColor(_remote.getString(_colorField)));
      logger.d('New importance color: ${_remote.getString(_colorField)}');

      _remote.onConfigUpdated.listen((event) async {
        await _remote.activate();
        emit(HexColor(_remote.getString(_colorField)));
        logger.d('New importance color: ${_remote.getString(_colorField)}');
      });
    } on FirebaseException catch (e) {
      logger.e('$e');
      rethrow;
    }
  }
}
