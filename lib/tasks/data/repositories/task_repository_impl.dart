import 'package:hive/hive.dart';
import 'package:note_book/core/utils/utils.dart';
import 'package:note_book/tasks/data/data_sources/local/task.dart';
import 'package:note_book/tasks/data/data_sources/remote/remote_api_service.dart';
import 'package:note_book/tasks/domain/entities/task_entity.dart';
import 'package:note_book/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  late final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasks');
  final RemoteApiService _remoteApiService;

  TaskRepositoryImpl(this._remoteApiService);

  @override
  Future<int> addTask(TaskEntity task) async {
    try {
      TaskModel newtask = TaskModel.fromEntity(task);
      newtask.uuid = getUuid();
      newtask.createdAt = DateTime.now().toIso8601String();
      newtask.updatedAt = DateTime.now().toIso8601String();

      return _taskBox.add(newtask);
    } catch (e) {
      Future.error(e);
      return -1;
    }
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    try {
      await _taskBox.delete(task.key);
    } catch (e) {
      Future.error(e);
    }
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    try {
      return List<TaskEntity>.from(
          _taskBox.values.toList().map((e) => TaskEntity.fromJson(e.toJson())));
    } catch (e) {
      Future.error(e);
      return [];
    }
  }

  @override
  Future<void> markTask(TaskEntity task) async {
    try {
      TaskModel newtask = TaskModel.fromEntity(task);
      TaskModel? oldtask = _taskBox.get(task.key);
      if (oldtask != null) {
        newtask.createdAt = oldtask.createdAt;
        newtask.uuid = oldtask.uuid;
        newtask.updatedAt = DateTime.now().toIso8601String();
      }
      newtask.clearedAt =
          newtask.isDone == true ? DateTime.now().toIso8601String() : null;

      await _taskBox.put(task.key, newtask);
    } catch (e) {
      Future.error(e);
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    try {
      TaskModel? oldtask = _taskBox.get(task.key);
      TaskModel newtask = TaskModel.fromEntity(task);
      if (oldtask != null) {
        newtask.createdAt = oldtask.createdAt;
        newtask.uuid = oldtask.uuid;
        newtask.updatedAt = DateTime.now().toIso8601String();
      }

      newtask.clearedAt =
          newtask.isDone == true ? DateTime.now().toIso8601String() : null;
      newtask.updatedAt = DateTime.now().toIso8601String();
      await _taskBox.put(task.key, newtask);
    } catch (e) {
      Future.error(e);
    }
  }
}
