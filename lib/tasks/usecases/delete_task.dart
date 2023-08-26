import 'package:note_book/core/usercases/usecase.dart';
import 'package:note_book/tasks/data/task.dart';
import 'package:note_book/tasks/data/task_repository.dart';

class DeleteTaskUseCase implements UseCase<void, Task> {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  @override
  Future<void> call({Task? params}) {
    return _taskRepository.deleteTask(params!);
  }
}
