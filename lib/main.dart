import 'package:deepflow/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:deepflow/pages/task_list_page.dart';
import 'package:deepflow/pages/project_create_page.dart';

void main() => runApp(Deepflow());

class Deepflow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deepflow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: SplashPage(callback: _handleHomeScreen(),),
      routes: {
        '/home': (context) => ProjectGeneratorPage(),
        '/taskgenerator': (context) => TaskGeneratorPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _handleHomeScreen() {
    return ProjectGeneratorPage();
//    return StreamBuilder<FirebaseUser>(
//        stream: FirebaseAuth.instance.onAuthStateChanged,
//        builder: (BuildContext context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return SplashPage();
//          } else {
//            if (snapshot.hasData) {
//              return ProjectGeneratorPage();
//            } else {
//              return LoginSignUpPage();
//            }
//          }
//        }
//    );
  }

}