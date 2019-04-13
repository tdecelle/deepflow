import 'package:flutter/material.dart';

class TimeEstimateAlertWidget extends StatefulWidget {
  TimeEstimateAlertWidget({@required this.initialTimeEstimate});

  final double initialTimeEstimate;

  @override
  State<TimeEstimateAlertWidget> createState() => TimeEstimateAlertState();
}

class TimeEstimateAlertState extends State<TimeEstimateAlertWidget> {
  double _timeEstimate;

  @override
  void initState() {
    super.initState();
    _timeEstimate = widget.initialTimeEstimate;
  }

  _setEstimate() {
    Navigator.pop(context, _timeEstimate);
  }

  //TODO: stop people from closing the dialog if they don't click "Set Estimate"
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Time Estimate'),
      content: Container(
        height: 55,
        child: Column(
          children: <Widget>[
            Text(_timeEstimate.toInt() == 60 ? "About: ${_timeEstimate.toInt()}+ minutes" : "About: ${_timeEstimate.toInt()} minutes"),
            Slider(
              value: _timeEstimate,
              min: 1.0,
              max: 60.0,
              onChanged: (newValue) => setState(() => _timeEstimate = newValue),
            ),
          ],
        ),
      ),
      actions: <Widget>[
//        FlatButton(
//          child: Text("Don't Estimate"),
//          onPressed: () => Navigator.pop(context),
//        ),
        FlatButton(
          child: Text("Set Estimate"),
          onPressed: () => _setEstimate(),
        ),
      ],
    );
  }
}