import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/bloc/task_bloc_states.dart';
import 'package:note_book/tasks/usecases/delete_task.dart';
import 'package:note_book/tasks/usecases/edit_task.dart';
import 'package:note_book/tasks/usecases/get_tasks.dart';
import 'package:note_book/tasks/usecases/save_task.dart';

class TaskBloc extends Bloc<TaskEvent, TasksState> {
  final GetTasksUseCase _getTasksUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final EditTaskUseCase _editTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskBloc(this._getTasksUseCase, this._saveTaskUseCase, this._editTaskUseCase,
      this._deleteTaskUseCase)
      : super(const TasksLoading()) {
    on<GetTasksEvent>(onGetTasksEvent);
    on<SaveTaskEvent>(onSaveTaskEvent);
    on<EditTaskEvent>(onEditTaskEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
  }

  void onGetTasksEvent(GetTasksEvent event, Emitter<TasksState> emit) async {
    final tasks = await _getTasksUseCase();
    emit(TasksDone(tasks));
  }

  void onSaveTaskEvent(SaveTaskEvent event, Emitter<TasksState> emit) async {
    await _saveTaskUseCase(params: event.task);
    final tasks = await _getTasksUseCase();
    emit(TasksDone(tasks));
  }

  void onEditTaskEvent(EditTaskEvent event, Emitter<TasksState> emit) async {
    await _editTaskUseCase(params: event.task);
    final tasks = await _getTasksUseCase();
    emit(TasksDone(tasks));
  }

  void onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    await _deleteTaskUseCase(params: event.task);
    final tasks = await _getTasksUseCase();
    emit(TasksDone(tasks));
  }
}
