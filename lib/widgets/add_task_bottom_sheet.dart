import 'package:flutter/material.dart';

class AddTaskBottomSheet {

  AddTaskBottomSheet({@required this.context, @required this.controller, @required this.callback});

  final context;
  final TextEditingController controller;
  final Function callback;

  show() {
    return showModalBottomSheet(
        context: this.context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: this.controller,
                      decoration: InputDecoration(
                        hintText: "Add a Task",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (this.controller.text.isNotEmpty)
                        this.callback(this.controller.text);
                    },
                    icon: Icon(Icons.arrow_upward),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}