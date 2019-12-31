import 'package:animations/commons/collapsing_navigation.dart';
import 'package:animations/login.dart';
import 'package:animations/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animations",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: drawerBackgroundColor,
        title: Text("Animations"),
      ),
      body: Stack(
        children: <Widget>[
          Login(),
          CollapsingNavigationDrawer(),
        ],
      ),
//      drawer: CollapsingNavigationDrawer(),
    );
  }
}

