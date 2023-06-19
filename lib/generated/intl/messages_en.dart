// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "Completed - ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "deadline_do_until": MessageLookupByLibrary.simpleMessage("Do until"),
        "main_subtitle": m0,
        "main_title": MessageLookupByLibrary.simpleMessage("My todos"),
        "priority": MessageLookupByLibrary.simpleMessage("Priority"),
        "priority_high": MessageLookupByLibrary.simpleMessage("High"),
        "priority_low": MessageLookupByLibrary.simpleMessage("Low"),
        "priority_none": MessageLookupByLibrary.simpleMessage("None"),
        "todo_editing_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "todo_editing_do_something":
            MessageLookupByLibrary.simpleMessage("Do something..."),
        "todo_new": MessageLookupByLibrary.simpleMessage("New")
      };
}
