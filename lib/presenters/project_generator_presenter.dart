import 'package:flutter/material.dart';
import 'package:deepflow/pages/task_list_page.dart';

class ProjectGeneratorPresenter {
  swapToTaskGenerator(context, projectTitle) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TaskGeneratorPage(title: projectTitle),
      ),
    );
  }
}