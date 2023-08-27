import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/core/app_routes/app_routes.dart';
import 'package:note_book/injection_container.dart';
import 'package:note_book/tasks/bloc/task_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/view/list_tasks_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TaskBloc>(
            create: (context) => sl()..add(const GetTasksEvent())),
      ],
      child: MaterialApp(
        title: "Task App",
        theme: ThemeData(primaryColor: Colors.amber),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const ListTaskView(),
      ),
    );
  }
}
