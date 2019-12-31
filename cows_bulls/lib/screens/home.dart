import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cows_bulls/screens/give_number.dart';
import 'package:cows_bulls/screens/guess_number.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Task'),

      ),
      body: Column(
        children: <Widget>[

          Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: 300,
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text('Give Number', textScaleFactor: 1.5,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return GiveNumber();
                  }));
                },
              ),
            ),
          ),

          Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: 300,
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text('Guess Number', textScaleFactor: 1.5,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return GuessNumber();
                  }));
                }
              ),
            ),
          ),

        ],
      ),
    );
  }

}