import 'package:hive/hive.dart';
import './task.dart';

class TaskRepository {
  final Box<Task> taskBox = Hive.box<Task>('tasks');

  Future<List<Task>> getAllTasks() async {
    return taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    taskBox.add(task);
  }

  Future<void> markTask(Task task) async {
    return await taskBox.put(task.key, task);
  }

  Future<void> updateTask(Task task) async {
    await task.save();
  }

  Future<void> deleteTask(Task task) async {
    // await taskBox.delete(task.key);
    await task.delete();
  }
}
