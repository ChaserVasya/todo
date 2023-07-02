import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/uikit/snack_bars/error.dart';

void handleExceptions() {
  Bloc.observer = _BlocErrorHandler();
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();
ScaffoldMessengerState? get _messenger => messengerKey.currentState;

class _BlocErrorHandler extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _messenger?.showSnackBar(ErrorSnackBar(error));
    super.onError(bloc, error, stackTrace);
  }
}
