import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child : Container(
        alignment: Alignment.center,
        color: Colors.deepPurple,
//        width: 200.0,
//        height: 100.0,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.only(left: 10.0, top: 40.0),
        child: ColumnWidget(),
      )
    );

  }

}

class ButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
        color: Colors.deepOrange,
        elevation: 6.0,
        child: Text(
          "Click This",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'Raleware',
            fontWeight: FontWeight.w700
          ),
        ),
        onPressed: () => pressed(context)
      ),
    );
  }

  void pressed(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("Button Pressed"),
      content: Text("You are Pressing the button"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog
    );
  }
}

class ImageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/Kajal.jpg');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(child: image, margin: EdgeInsets.only(top: 30.0),);
  }
}

class TextWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "Flight",
      textDirection: TextDirection.ltr,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: 35.0,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }

}

class ColumnWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        RowWidget(),
        ImageWidget(),
        ButtonWidget()
      ],
    );
  }
}

class RowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Expanded(child: TextWidget()),
        Expanded(child: TextWidget()),
        Expanded(child: TextWidget()),
        Expanded(child: TextWidget()),
        Expanded(child: TextWidget())
      ],
    );
  }
}