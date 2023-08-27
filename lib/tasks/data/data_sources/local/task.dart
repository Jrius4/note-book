import 'package:hive/hive.dart';
import 'package:note_book/tasks/domain/entities/task_entity.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? content;
  @HiveField(3)
  bool? isDone;
  @HiveField(4)
  String? clearedAt;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;

  TaskModel(
      {this.uuid,
      this.title,
      this.content,
      this.isDone = false,
      this.clearedAt,
      this.createdAt,
      this.updatedAt});

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
        uuid: entity.uuid,
        title: entity.title,
        content: entity.content,
        isDone: entity.isDone,
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "uuid": uuid,
        "title": title,
        "content": content,
        "isDone": isDone,
        "clearedAt": clearedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
