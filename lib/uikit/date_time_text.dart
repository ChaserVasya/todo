import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeText extends StatelessWidget {
  const DateTimeText(
    this.dateTime, {
    super.key,
    this.style,
  });

  final DateTime dateTime;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMMM y');

    return Text(formatter.format(dateTime), style: style);
  }
}
