import 'package:hive/hive.dart';
import 'package:note_book/tasks/data/remote_api_service.dart';
import 'package:note_book/tasks/data/task.dart';
import 'package:note_book/tasks/data/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final RemoteApiService _remoteApiService;
  final Task _task;
  TaskRepositoryImpl(this._remoteApiService, this._task);

  @override
  Future<void> addTask(Task task) {
    return taskBox.add(task);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> markTask(Task task) async {
    await task.save();
  }

  @override
  Future<void> updateTask(Task task) async {
    await task.save();
  }

  @override
  Box<Task> get taskBox => Hive.box<Task>('tasks');
}
