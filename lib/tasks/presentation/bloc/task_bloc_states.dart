import 'package:equatable/equatable.dart';
import 'package:note_book/tasks/domain/entities/task_entity.dart';

class TasksState extends Equatable {
  final List<TaskEntity>? tasks;
  const TasksState({this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksDone extends TasksState {
  const TasksDone(List<TaskEntity> tasks) : super(tasks: tasks);
}

class TasksError extends TasksState {
  const TasksError();
}
