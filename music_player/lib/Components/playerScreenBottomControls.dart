import 'package:flutter/material.dart';
import 'package:music_player/theme.dart';

class PlayerScreenBottomControls extends StatefulWidget {
  @override
  _PlayerScreenBottomControlsState createState() => _PlayerScreenBottomControlsState();
}

class _PlayerScreenBottomControlsState extends State<PlayerScreenBottomControls> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 40),
          child: Column(
            children: <Widget>[

              // Title and Artists
              RichText(
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: 'Song Title\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        height: 1.5,
                      ),
                    ),

                    TextSpan(
                      text: 'Artists\n',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        letterSpacing: 3.0,
                        height: 1.5,
                      )
                    )
                  ],
                ),
              ),

              // Play, Pause, Next and Previous buttons
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Container(),),
                    PreviousButton(),
                    Expanded(child: Container(),),
                    PlayPauseButton(),
                    Expanded(child: Container(),),
                    NextButton(),
                    Expanded(child: Container(),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      elevation: 10.0,
      highlightElevation: 5.0,
      onPressed: () => {},
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.play_arrow,
          color: darkAccentColor,
          size: 35,
        ),
      ),
    );
  }
}


class PreviousButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35,
      ),
      onPressed: () => {},
    );
  }
}

class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35,
      ),
      onPressed: () => {},
    );
  }
}


