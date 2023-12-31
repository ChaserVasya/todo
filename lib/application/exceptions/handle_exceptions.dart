import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/presentation/uikit/snack_bars/error.dart';

void handleExceptions() {
  Bloc.observer = _BlocErrorHandler();
  FlutterError.onError = (error) => getIt<Logger>().e(error.exception, null);
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<Logger>().e(error, stack);
    return true;
  };
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();
ScaffoldMessengerState? get _messenger => messengerKey.currentState;

class _BlocErrorHandler extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _messenger?.showSnackBar(ErrorSnackBar(error));
    getIt<FirebaseCrashlytics>().recordError(error, stackTrace, fatal: false);
    super.onError(bloc, error, stackTrace);
  }
}
