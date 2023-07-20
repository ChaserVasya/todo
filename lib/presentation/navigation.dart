import 'package:injectable/injectable.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/router/config.dart';
import 'package:todo/presentation/router/delegate.dart';

@lazySingleton
class Navigation {
  const Navigation(this._router);

  final AppRouterDelegate _router;

  void goToEdit([Todo? todo]) {
    _router.setNewRoutePath(AppConfig.edit(todo));
  }

  void goToMain() {
    _router.setNewRoutePath(const AppConfig.main());
  }
}
