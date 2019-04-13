import 'package:deepflow/model/task.dart';

class Model {
  static final Model _model = new Model._internal();

  final String _appTitle = 'deepflow';
  final List<Task> tasks = List<Task>();

  static get() {
    return _model;
  }

  appTitle() {
    return _appTitle;
  }

  addTask(Task name) {
    tasks.add(name);
  }

  getTasks() {
    return tasks;
  }

  getSmallestTasks() {
    List<Task> smallestTasks = List<Task>();
    for (final task in tasks) {
      if (task.getSubtasks().length == 0) {
        smallestTasks.add(task);
      } else {
        for (final subtask in task.getSmallestTasks()) {
          smallestTasks.add(subtask);
        }
      }
    }

    return smallestTasks;
  }

  Model._internal(); //private constructor
}