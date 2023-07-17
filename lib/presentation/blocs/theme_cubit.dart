import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeCubit extends Cubit<Brightness> {
  ThemeCubit() : super(Brightness.light);

  void toggle() {
    switch (state) {
      case Brightness.dark:
        return emit(Brightness.light);
      case Brightness.light:
        return emit(Brightness.dark);
    }
  }
}
