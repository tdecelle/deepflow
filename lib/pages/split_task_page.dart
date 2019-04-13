import 'package:deepflow/model/task.dart';
import 'package:deepflow/presenters/task_list_presenter.dart';
import 'package:deepflow/widgets/add_task_bottom_sheet.dart';
import 'package:deepflow/widgets/task_widget.dart';
import 'package:deepflow/widgets/time_estimate_alert_widget.dart';
import 'package:flutter/material.dart';

class SplitTaskPage extends StatefulWidget {
  SplitTaskPage({Key key, this.parentTask}) : super(key: key);

  final Task parentTask;

  _SplitTaskPageState createState() => _SplitTaskPageState();
}

class _SplitTaskPageState extends State<SplitTaskPage> {
  bool _showingBottomSheet = false;
  TextEditingController _addTaskController = TextEditingController();

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
    setState(() => TaskListPresenter.get().addSubtask(widget.parentTask, taskName));
  }

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

  @override
  Widget build(BuildContext context) {
    // TODO: test build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parentTask.name),
      ),
      body: Center(
        child: widget.parentTask.getSubtasks().length == 0
            ? Text("Split ${widget.parentTask.name} into subtasks.")
            : ListView.builder(
          itemCount: widget.parentTask.getSubtasks().length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: TaskWidget(
                task: widget.parentTask.getSubtasks()[index],
              ),
            );
          },
        ),
      ),
      floatingActionButton: _showingBottomSheet ? null
          : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showModalBottomSheet(context),
      ),
    );
  }
}