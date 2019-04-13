import 'package:flutter/material.dart';
import 'package:deepflow/model/model.dart';
import 'package:deepflow/presenters/project_generator_presenter.dart';

class ProjectGeneratorPage extends StatefulWidget {
  ProjectGeneratorPage({Key key, this.title, this.onSignedOut, this.userId}) : super(key: key);

  final String title;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _ProjectGeneratorPageState createState() => _ProjectGeneratorPageState();
}

class _ProjectGeneratorPageState extends State<ProjectGeneratorPage> {
  final _projectTitle = TextEditingController();
  bool _validate = false;
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _projectTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Model.get().appTitle()),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {
////              FirebaseAuth.instance.signOut();
//            },
//          ),
//        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _projectTitle,
              focusNode: _focusNode,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 5.0),
                ),
                hintText: 'Please enter your project name',
                errorText: _validate ? 'Must have a project name' : null,
              ),
              textInputAction: TextInputAction.none,
              onChanged: (string) {
                setState(() {
                  _validate = false;
                });
              },
            ),
            RaisedButton(
              child: Text("Create"),
              onPressed: () {
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _projectTitle.text.isEmpty
                      ? _validate = true
                      : new ProjectGeneratorPresenter().swapToTaskGenerator(context, _projectTitle.text);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}