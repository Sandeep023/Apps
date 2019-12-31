import 'package:flutter/material.dart';
import 'package:music_player/Components/albumCard.dart';
import 'dart:io';

import 'package:music_player/theme.dart';

class Albums extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAlbums();
  }
}

class StateAlbums extends State<Albums> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(child: AlbumCard()),
            Flexible(child: AlbumCard()),
          ],
        ),

        Row(
          children: <Widget>[
            Flexible(child: AlbumCard()),
            Flexible(child: AlbumCard()),
          ],
        ),
      ],
    );
  }
}