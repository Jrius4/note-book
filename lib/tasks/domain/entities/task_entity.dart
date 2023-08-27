import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TaskEntity extends Equatable {
  dynamic key;
  String? uuid;
  String? title;
  String? content;
  String? clearedAt;
  String? createdAt;
  String? updatedAt;
  bool? isDone;

  TaskEntity(
      {this.key,
      this.uuid,
      this.title,
      this.content,
      this.isDone = false,
      this.clearedAt,
      this.createdAt,
      this.updatedAt});
  @override
  List<Object?> get props {
    return [key, uuid, title, content, isDone, clearedAt, createdAt, updatedAt];
  }

  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        key: json["key"],
        uuid: json["uuid"],
        isDone: json["isDone"],
        title: json["title"],
        content: json["content"],
        clearedAt: json["clearedAt"] != null
            ? DateFormat.yMMMMEEEEd().format(DateTime.parse(json["clearedAt"]))
            : "",
        createdAt: json["createdAt"] != null
            ? DateFormat.yMMMMEEEEd().format(DateTime.parse(json["createdAt"]))
            : "",
        updatedAt: json["updateAt"] != null
            ? DateFormat.yMMMMEEEEd().format(DateTime.parse(json["updateAt"]))
            : "",
      );
}
