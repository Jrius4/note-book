import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_book/tasks/data/data_sources/local/task.dart';
import 'package:note_book/tasks/presentation/bloc/task_bloc.dart';
import 'package:note_book/tasks/data/data_sources/remote/remote_api_service.dart';

import 'package:note_book/tasks/domain/repositories/task_repository.dart';
import 'package:note_book/tasks/data/repositories/task_repository_impl.dart';
import 'package:note_book/tasks/domain/usecases/delete_task.dart';
import 'package:note_book/tasks/domain/usecases/edit_task.dart';
import 'package:note_book/tasks/domain/usecases/get_tasks.dart';
import 'package:note_book/tasks/domain/usecases/save_task.dart';

//  BlocProvider(
//             create: (context) => TaskBloc())
final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // local databse
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  sl.registerSingleton<TaskModel>(TaskModel());

  await Hive.openBox<TaskModel>('tasks');

  // remote
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<RemoteApiService>(RemoteApiService(sl()));

  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl()));
  // sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl(), sl()));

  // use cases
  sl.registerSingleton<GetTasksUseCase>(GetTasksUseCase(sl()));
  sl.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(sl()));
  sl.registerSingleton<EditTaskUseCase>(EditTaskUseCase(sl()));
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(sl()));
  // state management
  sl.registerFactory<TaskBloc>(() => TaskBloc(sl(), sl(), sl(), sl()));
}
