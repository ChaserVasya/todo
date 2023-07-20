import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/assets.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/importance_color_cubit.dart';

class PriorityIcon extends StatelessWidget {
  final Priority priority;

  const PriorityIcon(this.priority, {super.key});

  @override
  Widget build(BuildContext context) {
    final importanceColor = context.watch<ImportanceColorCubit>().state;
    switch (priority) {
      case Priority.none:
        return const SizedBox.shrink();
      case Priority.low:
        return _wrapAsset(AssetIcons.lowPriority);
      case Priority.high:
        return _wrapAsset(
          AssetIcons.highPriority,
          importanceColor,
        );
    }
  }

  Widget _wrapAsset(String path, [Color? color]) {
return       SizedBox(
        height: 17,
        width: 17,
        child: SvgPicture.asset(
          path,
          colorFilter: color != null
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
        ),
      );
  }
}
