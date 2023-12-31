import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/http.dart';
import 'package:todo/data/dtos/todo_dto/todo_dto.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/repositories/revision_repository.dart';

part 'todo_service.g.dart';

@RestApi()
@lazySingleton
abstract class TodoService {
  @factoryMethod
  factory TodoService(Dio dio, RevisionRepository revRepo, Logger logger) {
    dio.interceptors.addAll([
      _addRevisionWrapper(revRepo),
      _addBodyMapper(),
      _addLogger(logger),
    ]);
    return _TodoService(dio);
  }

  @GET('/list')
  Future<List<TodoDto>> getTodos();

  @PATCH('/list')
  Future<List<TodoDto>> updateTodos(@Body() List<TodoDto> todos);

  @POST('/list')
  Future<TodoDto> createTodo(@Body() TodoDto todo);

  @PUT('/list/{id}')
  Future<TodoDto> updateTodo(@Path() Id id, @Body() TodoDto todo);

  @DELETE('/list/{id}')
  Future<TodoDto> deleteTodo(@Path() Id id);
}

InterceptorsWrapper _addRevisionWrapper(RevisionRepository revRepo) {
  const revHeader = 'X-Last-Known-Revision';
  const revResField = 'revision';

  return InterceptorsWrapper(
    onRequest: (opts, handler) {
      opts.headers[revHeader] = revRepo.get();
      handler.next(opts);
    },
    onResponse: (opts, handler) {
      final rev = opts.data[revResField] as int;
      revRepo.set(rev);
      handler.next(opts);
    },
  );
}

InterceptorsWrapper _addBodyMapper() {
  return InterceptorsWrapper(
    onResponse: (opts, handler) {
      opts.data = opts.data['list'] ?? opts.data['element'];
      handler.next(opts);
    },
    onRequest: (opts, handler) {
      if (opts.method == 'PATCH') {
        opts.data = {'list': opts.data};
      } else {
        opts.data = {'element': opts.data};
      }
      handler.next(opts);
    },
  );
}

InterceptorsWrapper _addLogger(Logger logger) {
  const encoder = JsonEncoder.withIndent('  ');
  return InterceptorsWrapper(
    onResponse: (opts, handler) {
      logger.d(
        'data: ${encoder.convert(opts.data)}\n' //
        'headers: ${encoder.convert(opts.headers.map)}\n' //
        ,
      );
      handler.next(opts);
    },
    onRequest: (opts, handler) {
      logger.d(
        'path: ${opts.path}\n' //
        'method: ${opts.method}\n' //
        'data: ${encoder.convert(opts.data)}\n' //
        'headers: ${encoder.convert(opts.headers)}\n' //
        ,
      );
      handler.next(opts);
    },
    onError: (opts, handler) {
      logger.e(
        'code: ${opts.response?.statusCode}\n' //
        'message: ${opts.response?.data}\n' //
        ,
      );
      handler.next(opts);
    },
  );
}
