import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    controller.text = todo;
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
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Что надо сделать...',
          ),
          controller: controller,
          onSubmitted: (todo) {
            context.read<TodoEditingCubit>().editTodo(todo);
          },
        ),
      ),
    );
  }
}
