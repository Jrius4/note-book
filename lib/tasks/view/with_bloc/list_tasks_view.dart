import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/bloc/task_bloc_states.dart';
import 'package:note_book/tasks/data/task.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TaskBloc>(context);
    return BlocBuilder<TaskBloc, TasksState>(builder: (context, state) {
      final List<Task>? tasks = state.tasks;
      return Scaffold(
        appBar: AppBar(title: const Text('Tasks')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add-task");
          },
          child: const Icon(Icons.add),
        ),
        body: Stack(
          children: [
            if (tasks == null)
              const Center(
                child: Text(
                  "No Tasks Found",
                ),
              )
            else if (tasks.isEmpty)
              const Center(
                child: Text(
                  "Add New Tasks",
                ),
              )
            else
              ListView.builder(
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
                                    tasksBloc.add(DeleteTaskEvent(task));
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
                          tasksBloc.add(EditTaskEvent(task));
                        },
                      ),
                    );
                  }),
          ],
        ),
      );
    });
  }
}
