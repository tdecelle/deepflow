class Task {
  String name;
  bool done = false;
  Future<double> timeEstimate;
  List<Task> _subtasks = new List<Task>();

  setName(String name) {
    this.name = name;
  }

  setTimeEstimate(Future<double> timeEstimate) {
    this.timeEstimate = timeEstimate;
  }

  addSubtask(Task subtask) {
    _subtasks.add(subtask);
  }

  List<Task> getSubtasks() {
    return _subtasks;
  }

  List<Task> getSmallestTasks() {
    final List<Task> smallestTasks = List<Task>();
    for (final task in _subtasks) {
      if (task.getSubtasks().length == 0) {
        smallestTasks.add(task);
      }
      else {
        for (final subtask in task.getSmallestTasks()) {
          smallestTasks.add(subtask);
        }
      }
    }

    return smallestTasks;
  }
}