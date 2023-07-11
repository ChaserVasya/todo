import 'package:todo/domain/models/todo.dart';

class AppConfig {
  final bool main;
  final bool edit;

  final Todo? todo;

  const AppConfig.main()
      : main = true,
        edit = false,
        todo = null;
  const AppConfig.edit([this.todo])
      : edit = true,
        main = false;
}
