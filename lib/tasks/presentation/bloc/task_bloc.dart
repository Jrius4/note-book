import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/tasks/presentation/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/presentation/bloc/task_bloc_states.dart';
import 'package:note_book/tasks/domain/usecases/delete_task.dart';
import 'package:note_book/tasks/domain/usecases/edit_task.dart';
import 'package:note_book/tasks/domain/usecases/get_tasks.dart';
import 'package:note_book/tasks/domain/usecases/save_task.dart';

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

  void onGetTasksEvent(
      GetTasksEvent getTasksEvent, Emitter<TasksState> emit) async {
    try {
      emit(const TasksLoading());
      final tasks = await _getTasksUseCase();

      emit(TasksDone(tasks));
    } catch (e) {
      Future.error(e);
      emit(const TasksError());
    }
  }

  void onSaveTaskEvent(
      SaveTaskEvent saveTaskEvent, Emitter<TasksState> emit) async {
    try {
      emit(const TasksLoading());
      await _saveTaskUseCase(params: saveTaskEvent.task);
      final tasks = await _getTasksUseCase();

      emit(TasksDone(tasks));
    } catch (e) {
      Future.error(e);
      emit(const TasksError());
    }
  }

  void onEditTaskEvent(
      EditTaskEvent editTaskEvent, Emitter<TasksState> emit) async {
    try {
      emit(const TasksLoading());
      await _editTaskUseCase(params: editTaskEvent.task);
      final tasks = await _getTasksUseCase();

      emit(TasksDone(tasks));
    } catch (e) {
      Future.error(e);
      emit(const TasksError());
    }
  }

  void onDeleteTaskEvent(
      DeleteTaskEvent deleteTaskEvent, Emitter<TasksState> emit) async {
    try {
      emit(const TasksLoading());
      await _deleteTaskUseCase(params: deleteTaskEvent.task);
      final tasks = await _getTasksUseCase();

      emit(TasksDone(tasks));
    } catch (e) {
      Future.error(e);
      emit(const TasksError());
    }
  }
}
