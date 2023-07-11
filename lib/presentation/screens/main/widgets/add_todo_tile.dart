import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/router/config.dart';
import 'package:todo/presentation/router/delegate.dart';
import 'package:todo/presentation/uikit/theme.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: IconButton(
          onPressed: () => AppRouterDelegate.of(context)
              .setNewRoutePath(const AppConfig.edit()),
          icon: const Icon(Icons.add),
        ),
        title: Text(
          L10n.of(context).todo_new,
          style: const TextStyle(color: ColorsUI.textTertiary),
        ),
      ),
    );
  }
}
