import 'package:flutter/foundation.dart';
import '../data/task.dart';
import '../data/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskViewModel() {
    _loadTasks();
  }

  void _loadTasks() async {
    _tasks = await _repository.getAllTasks();
    notifyListeners();
  }

  void fetchAllTasks() {
    _loadTasks();
  }

  void addTask(String title) {
    final newTask = Task(title: title);
    _repository.addTask(newTask);
    _loadTasks();
  }

  Future<void> updateTask(Task task) async {
    final newTask = task;
    await _repository.markTask(newTask);
    _loadTasks();
  }

  deleteTask(Task task) async {
    _repository.deleteTask(task);
    _loadTasks();
  }
}
