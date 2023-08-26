import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../view_models/task_view_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final tasks = viewModel.tasks;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add-task");
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
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
                                await viewModel.deleteTask(task);
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
                      // Update task's status
                      task.isDone = value;

                      await viewModel.updateTask(task);
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
