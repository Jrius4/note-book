import 'package:note_book/tasks/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();

  Future<void> addTask(TaskEntity task);

  Future<void> markTask(TaskEntity task);

  Future<void> updateTask(TaskEntity task);

  Future<void> deleteTask(TaskEntity task);
}
