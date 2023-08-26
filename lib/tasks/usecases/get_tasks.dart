import 'package:note_book/core/usercases/usecase.dart';
import 'package:note_book/tasks/data/task.dart';
import 'package:note_book/tasks/data/task_repository.dart';

class GetTasksUseCase implements UseCase<List<Task>, void> {
  final TaskRepository _taskRepository;
  GetTasksUseCase(this._taskRepository);

  @override
  Future<List<Task>> call({void params}) {
    return _taskRepository.getAllTasks();
  }
}
