import 'package:flutter/material.dart';
import 'package:note_book/tasks/view/add_task_view.dart';
import 'package:note_book/tasks/view/task_list_view.dart';
import 'package:note_book/tasks/view/with_bloc/list_tasks_view.dart';
import 'package:note_book/tasks/view/with_bloc/task_form_view.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(const ListTaskView(), settings);

      case "/add-task":
        return _materialRoute(TaskFormView(), settings);

      default:
        return _materialRoute(const ListTaskView(), settings);
    }
  }

  static Route _materialRoute(Widget view, RouteSettings settings) {
    return MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}
