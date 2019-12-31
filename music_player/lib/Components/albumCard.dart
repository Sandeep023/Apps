import 'package:flutter/material.dart';
import 'package:music_player/theme.dart';

class AlbumCard extends StatefulWidget {
  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/Kajal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container(),),

                    Row(
                      children: <Widget>[
                        Expanded(child: Container(),),

                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              fillColor: Colors.white,
                              elevation: 10.0,
                              highlightElevation: 5.0,
                              onPressed: () => {},
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text('data'),
            ),
          ],
        ),
      ),
    );
  }
}
