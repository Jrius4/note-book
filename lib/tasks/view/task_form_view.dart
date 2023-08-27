import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc.dart';
import 'package:note_book/tasks/bloc/task_bloc_events.dart';
import 'package:note_book/tasks/data/task.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TaskFormView extends StatelessWidget {
  TaskFormView({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final tasksBloc = BlocProvider.of<TaskBloc>(context);
    final Task? editTask = ModalRoute.of(context)?.settings.arguments as Task?;

    if (editTask != null) {
      _controller.text = editTask.title!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${editTask == null ? "Add Form" : "Edit Form"} Task'),
        elevation: 0,
      ),
      body: Column(children: [
        TextField(
          controller: _controller,
        ),
        ElevatedButton(
          onPressed: () {
            if (editTask == null) {
              final newTask = Task(title: _controller.text);

              BlocProvider.of<TaskBloc>(context).add(SaveTaskEvent(newTask));
            } else {
              editTask.title = _controller.text;
              BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(editTask));
            }

            Navigator.pushNamed(context, "/");
          },
          child: Text(editTask == null ? "Add" : 'Save Changes'),
        ),
      ]),
    );
  }
}