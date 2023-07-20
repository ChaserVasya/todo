import 'package:floor/floor.dart';
import 'package:todo/domain/models/todo.dart';

@entity
class TodoEntity {
  @primaryKey
  final Id? id;
  final String text;
  final String importance;
  final int? deadline;
  final bool done;
  final String? color;
  final int? createdAt;
  final int? changedAt;
  final String? lastUpdatedBy;

  const TodoEntity({
    this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });
}
