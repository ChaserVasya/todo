import 'package:flutter/material.dart';
import 'package:todo/uikit/theme.dart';

class WarningIcon extends StatelessWidget {
  const WarningIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const highPriorityIcon = SizedBox(
      height: 16,
      width: 5,
      child: Icon(
        Icons.priority_high_rounded,
        color: ColorsUI.red,
      ),
    );

    return SizedBox(
      height: 16,
      width: 16,
      child: Row(
        children: const [
          highPriorityIcon,
          SizedBox(width: 3),
          highPriorityIcon,
        ],
      ),
    );
  }
}
