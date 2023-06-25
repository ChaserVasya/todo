// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/uikit/date_time_text.dart';
import 'package:todo/uikit/helpers.dart' as helpers;
import 'package:todo/uikit/theme.dart';

class DeadlineEditingTile extends StatelessWidget {
  const DeadlineEditingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ln = helpers.ln(context);

    return BlocSelector<TodoEditingCubit, TodoEditingState, DateTime?>(
      selector: _getDateFromState,
      builder: (context, deadline) {
        return SwitchListTile(
          title: Text(ln.deadline_do_until),
          value: deadline != null,
          onChanged: (hasDeadline) {
            if (hasDeadline) {
              _showDeadlinePicker(context, deadline);
            } else {
              context.read<TodoEditingCubit>().editDeadline(null);
            }
          },
          subtitle: deadline == null
              ? null
              : GestureDetector(
                  onTap: () => _showDeadlinePicker(context, deadline),
                  child: DateTimeText(
                    deadline,
                    style: const TextStyle(color: ColorsUI.blue),
                  ),
                ),
        );
      },
    );
  }

  DateTime? _getDateFromState(TodoEditingState state) {
    return state.map(
      editing: (state) => state.deadline,
      completed: (state) => state.todo.deadline,
    );
  }

  Future<void> _showDeadlinePicker(
    BuildContext context, [
    DateTime? currentDeadline,
  ]) async {
    final date = await showDatePicker(
      context: context,
      initialDate: currentDeadline ?? DateTime.now(),
      currentDate: currentDeadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date == null) return;
    if (!context.mounted) return;

    context.read<TodoEditingCubit>().editDeadline(date);
  }
}
