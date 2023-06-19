// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Мои дела`
  String get main_title {
    return Intl.message(
      'Мои дела',
      name: 'main_title',
      desc: '',
      args: [],
    );
  }

  /// `Выполнено - {count}`
  String main_subtitle(Object count) {
    return Intl.message(
      'Выполнено - $count',
      name: 'main_subtitle',
      desc: '',
      args: [count],
    );
  }

  /// `Новое`
  String get todo_new {
    return Intl.message(
      'Новое',
      name: 'todo_new',
      desc: '',
      args: [],
    );
  }

  /// `Важность`
  String get priority {
    return Intl.message(
      'Важность',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get priority_none {
    return Intl.message(
      'Нет',
      name: 'priority_none',
      desc: '',
      args: [],
    );
  }

  /// `Низкий`
  String get priority_low {
    return Intl.message(
      'Низкий',
      name: 'priority_low',
      desc: '',
      args: [],
    );
  }

  /// `Высокий`
  String get priority_high {
    return Intl.message(
      'Высокий',
      name: 'priority_high',
      desc: '',
      args: [],
    );
  }

  /// `Сделать до`
  String get deadline_do_until {
    return Intl.message(
      'Сделать до',
      name: 'deadline_do_until',
      desc: '',
      args: [],
    );
  }

  /// `Сделать что-то...`
  String get todo_editing_do_something {
    return Intl.message(
      'Сделать что-то...',
      name: 'todo_editing_do_something',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get todo_editing_delete {
    return Intl.message(
      'Удалить',
      name: 'todo_editing_delete',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
