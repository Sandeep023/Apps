import 'package:flutter/material.dart';
import 'package:music_player/Components/albums.dart';
import 'package:music_player/theme.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateHomePage();
  }
}

class StateHomePage extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        title: Text('Music You Love'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Albums(),
      )
    );
  }
}