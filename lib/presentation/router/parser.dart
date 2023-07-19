import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/data/dtos/todo_dto/todo_dto.dart';
import 'package:todo/data/mappers/todo_mapper.dart';

import 'config.dart';

@lazySingleton
class AppRouteInformationParser extends RouteInformationParser<AppConfig> {
  final Logger _logger;

  const AppRouteInformationParser(this._logger);

  @override
  Future<AppConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    _logger.d(routeInformation.location);
    final location = routeInformation.location;
    if (location == null) {
      return const AppConfig.main();
    }
    final path = Uri.parse(location);
    if (path.pathSegments.isEmpty) {
      return const AppConfig.main();
    }
    if (path.pathSegments[0] == 'edit') {
      final query = path.query;
      if (query.isEmpty) {
        return const AppConfig.edit();
      }
      final todo = getIt<TodoMapper>()
          .fromDto(TodoDto.fromJson(jsonDecode(query) as Map<String, dynamic>));
      return AppConfig.edit(todo);
    }
    return const AppConfig.main();
  }
}
