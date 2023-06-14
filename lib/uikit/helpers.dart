import 'package:flutter/material.dart';

ThemeData th(BuildContext context) {
  return Theme.of(context);
}

ColorScheme csh(BuildContext context) {
  return th(context).colorScheme;
}

TextTheme tth(BuildContext context) {
  return th(context).textTheme;
}
