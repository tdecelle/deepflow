import 'package:deepflow/widgets/add_task_bottom_sheet.dart';
import 'package:deepflow/widgets/task_widget.dart';
import 'package:deepflow/widgets/time_estimate_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:deepflow/presenters/task_list_presenter.dart';


class TaskGeneratorPage extends StatefulWidget {
  TaskGeneratorPage({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _TaskGeneratorPageState createState() => _TaskGeneratorPageState();
}

class _TaskGeneratorPageState extends State<TaskGeneratorPage> {
  final TextEditingController _addTaskController = TextEditingController();
  bool _showingBottomSheet = false;
  bool _showingSmallestTasks = false;

  Future<double> _getTimeEstimate() async {
    Navigator.pop(context);
    return showDialog<double>(
        context: context,
        builder: (context) => TimeEstimateAlertWidget(initialTimeEstimate: 15.0,),
    );
  }

  _addTask(String taskName) {
    _addTaskController.text = "";
    TaskListPresenter.get().setTimeEstimate(_getTimeEstimate());
    setState(() => TaskListPresenter.get().addTask(taskName));
  }

  //TODO: It would be nice if the bottom sheet didn't fade the rest of the screen.
  _showModalBottomSheet(context) {
    AddTaskBottomSheet(
      context: context,
      controller: _addTaskController,
      callback: _addTask,
    ).show().then((onValue) => setState(() => _showingBottomSheet = false));

    setState(() {
      _showingBottomSheet = true;
    });
  }

  Widget _getOverviewTasks() {
    if (TaskListPresenter.get().getTasks().length == 0) {
      return Text("Add a task", style: TextStyle(fontSize: 20,),);
    }
    else {
      return ListView.builder(
        itemCount: TaskListPresenter.get().getTasks().length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: TaskWidget(
              task: TaskListPresenter.get().getTasks()[index],
            ),
          );
        },
      );
    }
  }

  Widget _getSmallestTasks() {
    final smallestTasks = TaskListPresenter.get().getSmallestTasks();
    if (TaskListPresenter.get().getTasks().length == 0) {
      return Text("Add a task", style: TextStyle(fontSize: 20,),);
    }
    else {
      return ListView.builder(
        itemCount: smallestTasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: TaskWidget(
              task: smallestTasks[index],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () => setState(() =>_showingSmallestTasks = !_showingSmallestTasks),
          ),
        ],
      ),
      body: Center(
        child: _showingSmallestTasks ? _getSmallestTasks() : _getOverviewTasks(),
      ),
      floatingActionButton: _showingBottomSheet ? null
          : FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showModalBottomSheet(context)
      ),
    );
  }
}