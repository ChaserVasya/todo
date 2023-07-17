import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/blocs/importance_color_cubit.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/uikit/helpers.dart' as helpers;
import 'package:todo/presentation/widgets/priority_icon.dart';

class PriorityEditingTile extends StatelessWidget {
  const PriorityEditingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ln = helpers.ln(context);

    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        final color = context.watch<ImportanceColorCubit>().state;
        return [
          for (final priority in Priority.values)
            PopupMenuItem(
              child: _priorityText(priority, ln, color),
              onTap: () {
                context.read<TodoEditingCubit>().editPriority(priority);
              },
            ),
        ];
      },
      child: ListTile(
        title: Text(ln.priority),
        subtitle: BlocSelector<TodoEditingCubit, TodoEditingState, Priority>(
          selector: (state) => state.map(
            editing: (state) => state.priority,
            completed: (state) => state.todo.priority,
          ),
          builder: (context, priority) {
            return BlocBuilder<ImportanceColorCubit, Color>(
              builder: (context, state) {
                return _priorityText(priority, ln, state);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _priorityText(Priority priority, L10n ln, Color color) {
    switch (priority) {
      case Priority.none:
        return Text(ln.priority_none);
      case Priority.low:
        return Text(ln.priority_low);
      case Priority.high:
        return Row(children: [
          PriorityIcon(priority),
          Text(
            ln.priority_high,
            style: TextStyle(color: color),
          ),
        ]);
    }
  }
}
