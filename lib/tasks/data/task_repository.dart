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
}
