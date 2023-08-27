import 'package:note_book/core/usercases/usecase.dart';
import 'package:note_book/tasks/domain/entities/task_entity.dart';
import 'package:note_book/tasks/domain/repositories/task_repository.dart';

class GetTasksUseCase implements UseCase<List<TaskEntity>, void> {
  final TaskRepository _taskRepository;
  GetTasksUseCase(this._taskRepository);

  @override
  Future<List<TaskEntity>> call({void params}) {
    return _taskRepository.getAllTasks();
  }
}
