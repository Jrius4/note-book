import 'package:equatable/equatable.dart';

import 'package:note_book/tasks/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  final TaskEntity? task;
  const TaskEvent({this.task});
  @override
  List<Object> get props => [task!];
}

class GetTasksEvent extends TaskEvent {
  const GetTasksEvent();
}

class SaveTaskEvent extends TaskEvent {
  const SaveTaskEvent(TaskEntity task) : super(task: task);
}

class EditTaskEvent extends TaskEvent {
  const EditTaskEvent(TaskEntity task) : super(task: task);
}

class DeleteTaskEvent extends TaskEvent {
  const DeleteTaskEvent(TaskEntity task) : super(task: task);
}
