// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count) => "Выполнено - ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "deadline_do_until": MessageLookupByLibrary.simpleMessage("Сделать до"),
        "main_subtitle": m0,
        "main_title": MessageLookupByLibrary.simpleMessage("Мои дела"),
        "priority": MessageLookupByLibrary.simpleMessage("Важность"),
        "priority_high": MessageLookupByLibrary.simpleMessage("Высокий"),
        "priority_low": MessageLookupByLibrary.simpleMessage("Низкий"),
        "priority_none": MessageLookupByLibrary.simpleMessage("Нет"),
        "todo_editing_delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "todo_editing_do_something":
            MessageLookupByLibrary.simpleMessage("Сделать что-то..."),
        "todo_editing_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "todo_new": MessageLookupByLibrary.simpleMessage("Новое")
      };
}
