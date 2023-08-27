import 'package:note_book/core/usercases/usecase.dart';
import 'package:note_book/tasks/domain/entities/task_entity.dart';
import 'package:note_book/tasks/domain/repositories/task_repository.dart';

class SaveTaskUseCase implements UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({TaskEntity? params}) {
    return _taskRepository.addTask(params!);
  }
}
