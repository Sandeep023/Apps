import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

class GuessNumber extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateGuessNumber();
  }

}

class StateGuessNumber extends State<GuessNumber> {

  String numberToGuess = "Getting Number";
  List<String> entered = new List();
  int count = 0;
  String dataText = "";
  String givenBy = "";
  String title = "Fetching Number";
  var formKey = GlobalKey<FormState>();

  TextEditingController numberController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<String> n = getNumber();
    n.then((value){
      setState(() {
        var d = value.split(":");
        numberToGuess = d[0];
        givenBy = d[1];
        title = "Guess the number by " + givenBy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(builder: (context) =>
        Column(
          children: <Widget>[
            Text(
              '*Wait till the Title of the page changes to Guess the number by ..',
            ),
            Container(height: 250,child:getForm(context)),
            Text(dataText),
          ],
        ),
      ),
    );
  }

  Form getForm(BuildContext context){
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextFormField(
                controller: numberController,
                keyboardType: TextInputType.number,
                validator: (String value){
                  if(value.length != 4){
                    return "Enter valid number of length four";
                  } else {
                    if(int.tryParse(value) == null){
                      return "Enter valid number";
                    }else if(value.contains('0')) {
                      return "Enter valid number with out 0";
                    }
                  }
                },
                decoration: InputDecoration(
                    labelText: "Number",
                    hintText: "Enter Your Number eg: 4597",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: RaisedButton(
                child: Text('Compare'),
                onPressed: (){
                  setState(() {
                    if(formKey.currentState.validate()) {
                      _compare(context);
                    }
                  });
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void _compare(BuildContext context) async{

    int bulls = 0;
    int cows = 0;
    count++;
    String number = numberController.text;
    entered.add(number);
    for(int i=0;i<4; i++) {
      var char = number[i];
      if (numberToGuess.contains(char)) {
        if (numberToGuess.indexOf(char) == i) {
          bulls++;
        } else {
          cows++;
        }
      }
    }
    if(bulls == 4){
      _showSnackBar(context, 'Hurray! You Guessed the number in ' + count.toString() + ' guessed');
    }
    setState(() {
//      entered.add(number + " - bulls:" + bulls.toString() + ", cows:" + cows.toString());
//      count = entered.length;
      dataText = dataText + "\n" + number + " - bulls:" + bulls.toString() + ", cows:" + cows.toString();
      if(bulls == 4){
        dataText = dataText + '\nYou Guessed the number in ' + count.toString() + ' guessed';
      }
      numberController.text = "";
    });

  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<String> getNumber() async{
    final String url = 'https://cowsbulls-0841.restdb.io/rest/number';

    var headers = {
      'content-type': "application/json",
      'x-apikey': "42ee2cdd4254c7fda50a7fa7713450daf2c82",
    };
    var responce = await http.get(Uri.encodeFull(url), headers: headers);

    var object = json.decode(responce.body);
    var data = object[0];
    return data['number'] + ":" + data['name'];
  }

}