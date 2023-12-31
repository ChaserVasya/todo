import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/importance_color_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/navigation.dart';
import 'package:todo/presentation/uikit/date_time_text.dart';
import 'package:todo/presentation/uikit/helpers.dart';
import 'package:todo/presentation/uikit/theme.dart';
import 'package:todo/presentation/widgets/priority_icon.dart';
import 'package:todo/utils/extensions.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(this.todo, {required LocalKey key}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return _TodoListSliding(
      key: key as LocalKey,
      todo: todo,
      child: ListTile(
        leading: _TodoCompletedCheckBox(todo),
        trailing: const Icon(Icons.info_outline),
        onTap: () => getIt<Navigation>().goToEdit(todo),
        title: Row(
          children: <Widget>[
            if (todo.priority != Priority.none && !todo.completed)
              PriorityIcon(todo.priority),
            Flexible(
              child: Text(
                todo.todo,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: todo.completed
                    ? const TextStyle(
                        color: ColorsUI.textTertiary,
                        decoration: TextDecoration.lineThrough,
                      )
                    : null,
              ),
            ),
          ].separateBy(const SizedBox(width: 10)),
        ),
        subtitle: todo.deadline != null
            ? DateTimeText(
                todo.deadline!,
                style: const TextStyle(color: ColorsUI.textTertiary),
              ) //
            : null,
      ),
    );
  }
}

class _TodoListSliding extends StatefulWidget {
  const _TodoListSliding({
    required LocalKey key,
    required this.todo,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Todo todo;

  @override
  State<_TodoListSliding> createState() => _TodoListSlidingState();
}

class _TodoListSlidingState extends State<_TodoListSliding> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      return Dismissible(
        key: widget.key!,
        onUpdate: (details) {
          setState(() {});
          progress = details.progress;
        },
        background: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorsUI.green,
            ),
            Positioned(
              left: width * progress - 50,
              top: 16,
              child: const Icon(
                Icons.check,
                color: ColorsUI.white,
              ),
            )
          ],
        ),
        secondaryBackground: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorsUI.red,
            ),
            Positioned(
              right: width * progress - 50,
              top: 16,
              child: const Icon(
                Icons.delete,
                color: ColorsUI.white,
              ),
            ),
          ],
        ),
        confirmDismiss: (dir) async {
          final bloc = context.read<TodosBloc>();
          if (dir == DismissDirection.startToEnd) {
            bloc.add(TodosEvent.update(widget.todo.copyWith(completed: true)));
          } else if (dir == DismissDirection.endToStart) {
            bloc.add(TodosEvent.delete(widget.todo.id!));
            return true;
          }
          return null;
        },
        child: widget.child,
      );
    });
  }
}

class _TodoCompletedCheckBox extends StatelessWidget {
  const _TodoCompletedCheckBox(this.todo);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        children: [
          if (todo.priority == Priority.high && !todo.completed)
            Positioned(
              top: 15,
              left: 15,
              child: BlocBuilder<ImportanceColorCubit, Color>(
                builder: (context, state) {
                  return Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: state.withOpacity(0.5),
                      border: Border.all(
                        color: state,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    alignment: Alignment.center,
                  );
                },
              ),
            ),
          Checkbox(
            value: todo.completed,
            onChanged: (completed) {
              context.read<TodosBloc>().add(
                    TodosEvent.update(todo.copyWith(completed: completed!)),
                  );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            fillColor: MaterialStateProperty.all(ColorsUI.green),
            side: BorderSide(
              color: th(context).dividerTheme.color!,
              width: 2,
            ),
          )
        ],
      ),
    );
  }
}
