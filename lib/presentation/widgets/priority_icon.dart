import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/assets.dart';
import 'package:todo/domain/models/todo.dart';

class PriorityIcon extends StatelessWidget {
  final Priority priority;

  const PriorityIcon(this.priority, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      case Priority.none:
        return const SizedBox.shrink();
      case Priority.low:
        return _wrapAsset(AssetIcons.lowPriority);
      case Priority.high:
        return _wrapAsset(AssetIcons.highPriority);
    }
  }

  Widget _wrapAsset(String path) {
    return SizedBox(
      height: 17,
      width: 17,
      child: SvgPicture.asset(path),
    );
  }
}
