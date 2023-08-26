import 'package:note_book/core/usercases/usecase.dart';
import 'package:note_book/tasks/data/task.dart';
import 'package:note_book/tasks/data/task_repository.dart';

class SaveTaskUseCase implements UseCase<void, Task> {
  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({Task? params}) {
    return _taskRepository.addTask(params!);
  }
}
