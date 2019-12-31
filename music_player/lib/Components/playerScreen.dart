import 'package:flutter/material.dart';
import 'package:music_player/Components/playerScreenBottomControls.dart';
import 'package:music_player/theme.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: accentColor,
          onPressed: () => {}
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            color: accentColor,
            onPressed: () => {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          //SeekBar
          Expanded(
            child: Container(),
          ),

          //Visualiser
          Container(
            width: double.infinity,
            height: 125.0,
          ),

          //BottomControls
          PlayerScreenBottomControls(),
        ],
      ),
    );
  }
}
