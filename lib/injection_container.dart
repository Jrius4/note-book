import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_book/tasks/bloc/task_bloc.dart';
import 'package:note_book/tasks/data/remote_api_service.dart';

import 'package:note_book/tasks/data/task.dart';
import 'package:note_book/tasks/data/task_repository.dart';
import 'package:note_book/tasks/data/task_repository_impl.dart';
import 'package:note_book/tasks/usecases/delete_task.dart';
import 'package:note_book/tasks/usecases/edit_task.dart';
import 'package:note_book/tasks/usecases/get_tasks.dart';
import 'package:note_book/tasks/usecases/save_task.dart';

//  BlocProvider(
//             create: (context) => TaskBloc())
final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  sl.registerSingleton<Task>(Task());

  await Hive.openBox<Task>('tasks');
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<RemoteApiService>(RemoteApiService(sl()));

  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl(), sl()));

  // use cases
  sl.registerSingleton<GetTasksUseCase>(GetTasksUseCase(sl()));
  sl.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(sl()));
  sl.registerSingleton<EditTaskUseCase>(EditTaskUseCase(sl()));
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(sl()));
  // state management
  sl.registerFactory<TaskBloc>(() => TaskBloc(sl(), sl(), sl(), sl()));
}
