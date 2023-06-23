import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/domain/models/todo.dart';

part 'todo_dto.freezed.dart';

part 'todo_dto.g.dart';

@freezed
class TodoDto with _$TodoDto {
  const factory TodoDto({
    Id? id,
    required String text,
    required String importance,
    int? deadline,
    required bool done,
    String? color,
    @JsonKey(name: "created_at") int? createdAt,
    @JsonKey(name: "changed_at") int? changedAt,
    @JsonKey(name: "last_updated_by") String? lastUpdatedBy,
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, dynamic> json) =>
      _$TodoDtoFromJson(json);
}
