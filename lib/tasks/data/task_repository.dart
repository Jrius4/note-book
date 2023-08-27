import 'package:hive/hive.dart';
import 'package:note_book/core/utils/utils.dart';
import './task.dart';

class TaskRepository {
  final Box<Task> taskBox = Hive.box<Task>('tasks');

  Future<List<Task>> getAllTasks() async {
    return taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    task.uuid = getUuid();
    taskBox.add(task);
  }

  Future<void> markTask(Task task) async {
    return taskBox.put(task.key, task);
  }

  Future<void> updateTask(Task task) async {
    task.save();
  }

  Future<void> deleteTask(Task task) async {
    // await taskBox.delete(task.key);
    task.delete();
  }
}
