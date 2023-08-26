import 'package:flutter/material.dart';
import 'package:note_book/tasks/view/add_task_view.dart';
import 'package:note_book/tasks/view/task_list_view.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(const TaskListView(), settings);
      case "/add-task":
        return _materialRoute(AddTaskView(), settings);
      default:
        return _materialRoute(const TaskListView(), settings);
    }
  }

  static Route _materialRoute(Widget view, RouteSettings settings) {
    return MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}
