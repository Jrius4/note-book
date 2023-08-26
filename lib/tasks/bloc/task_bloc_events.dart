import 'package:equatable/equatable.dart';
import 'package:note_book/tasks/data/task.dart';

abstract class TaskEvent extends Equatable {
  final Task? task;
  const TaskEvent({this.task});
  @override
  List<Object> get props => [task!];
}

class GetTasksEvent extends TaskEvent {
  const GetTasksEvent();
}

class SaveTaskEvent extends TaskEvent {
  const SaveTaskEvent(Task task) : super(task: task);
}

class EditTaskEvent extends TaskEvent {
  const EditTaskEvent(Task task) : super(task: task);
}

class DeleteTaskEvent extends TaskEvent {
  const DeleteTaskEvent(Task task) : super(task: task);
}
