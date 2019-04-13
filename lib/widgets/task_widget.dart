import 'package:deepflow/model/task.dart';
import 'package:deepflow/pages/split_task_page.dart';
import 'package:deepflow/widgets/time_estimate_alert_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({@required this.task,});

  final Task task;

  _TaskState createState() => new _TaskState();
}

class _TaskState extends State<TaskWidget> {

  Future<double> _getTimeEstimatePopup() async {
    return showDialog<double>(
      context: context,
      builder: (context) => TimeEstimateAlertWidget(initialTimeEstimate: 15.0,),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 18,
      decoration: widget.task.done ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  IconButton _getWaitingButton() {
    return IconButton(
      icon: Icon(Icons.bubble_chart),
      onPressed: () => {},
    );
  }

  IconButton _getTimeEstimateButton() {
    return IconButton(
      icon: Icon(
        Icons.alarm,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() => widget.task.setTimeEstimate(_getTimeEstimatePopup()));
      },
    );
  }

  Color _getSplitIndicationColor(int timeEstimate) {
    return timeEstimate > 15
        ? Color.fromARGB(255, 255, (255/timeEstimate).floor(), (255/timeEstimate).floor())
        : Color.fromARGB(255, 0, 0, 0);
  }

  IconButton _getSplitTaskButton(int timeEstimate) {
    return IconButton(
      icon: Icon(
        Icons.device_hub,
        color: _getSplitIndicationColor(timeEstimate),
      ),
      onPressed: () => _splitTask(),
    );
  }

  _splitTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplitTaskPage(parentTask: widget.task),
      ),
    );
  }

  Widget _getTimeEstimate() {
    return FutureBuilder<double>(
      future: widget.task.timeEstimate,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none: return _getWaitingButton();
          case ConnectionState.waiting: return _getWaitingButton();
          default:
            if (snapshot.hasError)
              return _getWaitingButton();
            else
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: snapshot.data != null
                    ? _getSplitTaskButton(snapshot.data.toInt())
                    : _getTimeEstimateButton(),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Checkbox(
                value: widget.task.done,
                onChanged: (bool) => setState(() => widget.task.done = bool),
              ),
              Text(
                widget.task.name,
                style: _getTextStyle(),
              ),
              _getTimeEstimate(),
            ],
          ),
          Divider(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

}