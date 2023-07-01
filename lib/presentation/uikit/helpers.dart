import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

ThemeData th(BuildContext context) {
  return Theme.of(context);
}

ColorScheme csh(BuildContext context) {
  return th(context).colorScheme;
}

TextTheme tth(BuildContext context) {
  return th(context).textTheme;
}

L10n ln(BuildContext context) {
  return L10n.of(context);
}
