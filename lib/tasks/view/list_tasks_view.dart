import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/core/utils/utils.dart';
import 'package:note_book/injection_container.dart';
import 'package:note_book/tasks/bloc/task_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/bloc/task_bloc_states.dart';
import 'package:note_book/tasks/data/task.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<TaskBloc>()
          ..add(
            const GetTasksEvent(),
          ),
        child: Scaffold(
          appBar: AppBar(title: const Text('Task Checklist')),
          body: _buildBodyContent(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/add-task");
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  Widget _buildBodyContent() {
    return BlocBuilder<TaskBloc, TasksState>(builder: (context, state) {
      if (state is TasksLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is TasksError) {
        return const Center(
          child: Text("Task Error"),
        );
      }
      if (state is TasksDone) {
        return _buildTaskList(state.tasks);
      }
      return Container();
    });
  }

  Widget _buildTaskList(List<Task>? tasks) {
    if (tasks == null) {
      return const Center(
        child: Text("SYSTEM ERROR"),
      );
    } else if (tasks.isEmpty) {
      return const Center(
        child: Text("NO SAVED ARTICLES"),
      );
    }

    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 50),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            dense: true,
            title: Text(task.title!),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/add-task',
                              arguments: task);
                        },
                        color: Colors.blue,
                        icon: const Icon(Icons.edit)),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          BlocProvider.of<TaskBloc>(context)
                              .add(DeleteTaskEvent(task));
                        },
                        color: Colors.red,
                        icon: const Icon(Icons.delete)),
                  )
                ],
              ),
            ),
            leading: Checkbox(
              value: task.isDone,
              onChanged: (value) async {
                task.isDone = value;
                BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(task));
              },
            ),
          );
        });
  }
}
