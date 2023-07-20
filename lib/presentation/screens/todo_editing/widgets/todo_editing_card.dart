import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';

class TodoEditingCard extends StatefulWidget {
  const TodoEditingCard({super.key});

  @override
  State<TodoEditingCard> createState() => _TodoEditingCardState();
}

class _TodoEditingCardState extends State<TodoEditingCard> {
  final controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final todo = context.watch<TodoEditingCubit>().state.map<String>(
          editing: (state) => state.todo,
          completed: (state) => state.todo.todo,
        );
    final oldValue = controller.value;
    final isTextPrinting = todo.length >= oldValue.text.length;
    controller.value = oldValue.copyWith(
      text: todo,
      selection: TextSelection.collapsed(
        offset: isTextPrinting
            ? oldValue.selection.baseOffset
            : oldValue.selection.baseOffset - 1,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: TextField(
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: L10n.of(context).todo_editing_do_something,
            ),
            controller: controller,
            onChanged: context.read<TodoEditingCubit>().editTodo,
          ),
        ),
      ),
    );
  }
}
