import 'package:flutter/material.dart';
import 'package:todo/presentation/uikit/theme.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar(Object error, {super.key})
      : super(
          content: Text(error.toString()),
          backgroundColor: ColorsUI.red,
        );
}
