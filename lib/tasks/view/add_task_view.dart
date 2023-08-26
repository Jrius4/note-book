import 'dart:developer';

import 'package:note_book/tasks/data/task.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../view_models/task_view_model.dart';

class AddTaskView extends StatelessWidget {
  AddTaskView({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final Task? editTask = ModalRoute.of(context)?.settings.arguments as Task?;
    inspect(ModalRoute.of(context)?.settings);
    if (editTask != null) {
      inspect(editTask);
      _controller.text = editTask.title!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${editTask == null ? "Add" : "Edit"}Task'),
        elevation: 0,
      ),
      body: Column(children: [
        TextField(
          controller: _controller,
        ),
        ElevatedButton(
          onPressed: () {
            if (editTask != null) {
              editTask.title = _controller.text;
              editTask.save();
              // viewModel.updateTask(editTask);
              viewModel.fetchAllTasks();
            } else {
              viewModel.addTask(_controller.text);
            }

            Navigator.pop(context);
          },
          child: Text(editTask == null ? "Add" : 'Edit'),
        ),
      ]),
    );
  }
}
