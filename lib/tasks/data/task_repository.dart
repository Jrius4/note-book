import 'package:hive/hive.dart';
import './task.dart';

class TaskRepository {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  List<Task> getAllTasks() {
    return _taskBox.values.toList();
  }

  void addTask(Task task) {
    _taskBox.add(task);
  }

  Future<void> markTask(Task task) async {
    return await _taskBox.put(task.key, task);
  }

  Future<void> deleteTask(Task task) async {
    await _taskBox.delete(task.key);
  }
}
