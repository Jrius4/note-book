import 'package:equatable/equatable.dart';
import 'package:note_book/tasks/data/task.dart';

class TasksState extends Equatable {
  final List<Task>? tasks;
  const TasksState({this.tasks});

  @override
  List<Object> get props => tasks != null ? [tasks!] : [];
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksDone extends TasksState {
  const TasksDone(List<Task> tasks) : super(tasks: tasks);
}

class TasksError extends TasksState {
  const TasksError();
}
