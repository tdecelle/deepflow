import 'package:deepflow/model/model.dart';
import 'package:deepflow/model/task.dart';

class TaskListPresenter {
  static final _taskListPresenter = TaskListPresenter._internal();

  TaskListPresenter._internal();

  static get() {
    return _taskListPresenter;
  }

  Task currentTask = Task();

  addTask(String taskName) {
    currentTask.setName(taskName);
    Model.get().addTask(currentTask);
    currentTask = Task();
  }

  addSubtask(Task parent, String subtaskName) {
    currentTask.setName(subtaskName);
    parent.addSubtask(currentTask);
    currentTask = Task();
  }

  setTimeEstimate(Future<double> estimate) {
    currentTask.setTimeEstimate(estimate);
  }

  getTasks() {
    return Model.get().getTasks();
  }

  getSmallestTasks() {
    return Model.get().getSmallestTasks();
  }
}