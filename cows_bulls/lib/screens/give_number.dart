import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GiveNumber extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateGiveNumber();
  }

}

class StateGiveNumber extends State<GiveNumber>{
  var formKey = GlobalKey<FormState>();
  Color colors = Colors.green;
  TextEditingController numberController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Your Number'),
      ),
      body: Builder(builder: (context) => Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (String value){
                    if(value.length == 0){
                      return "Enter valid name";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter Your Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
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
                    hintText: "Enter Your Number To Submit Here eg : 4587",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: RaisedButton(
                  child: Text('Submit'),
                  color: colors,
                  onPressed: (){
                    setState(() {
                      colors = Colors.red;
                    });
                    if(formKey.currentState.validate()) {
                      _saveToRestDB(context);
                    }
                  },
                ),
              )

            ],
          ),
        ),
      ),
    ),);
  }

  void _saveToRestDB(BuildContext context) async{
    String number = numberController.text;
    String name = nameController.text;
    final String url = 'https://cowsbulls-0841.restdb.io/rest/number';

    var headers = {
      'content-type': "application/json",
      'x-apikey': "42ee2cdd4254c7fda50a7fa7713450daf2c82",
    };
    var responce = await http.get(Uri.encodeFull(url), headers: headers);

    var object = json.decode(responce.body);
    var data = object[0];
    Map<String, dynamic> d = new Map();
    d['name'] = name;
    d['number'] = number;
    var dData = json.encode(d);

    var putUrl = url + '/' + data['_id'].toString();
    debugPrint(data['_id'].toString());
    debugPrint(putUrl);
    var responce_1 = await http.put(Uri.encodeFull(putUrl), headers: headers, body: dData);
    debugPrint(responce_1.body);
    if (responce_1.statusCode == 200){
      _showSnackBar(context, 'Added Number to Database');
    } else {
      _showSnackBar(context, 'Problem in saving the number');
    }
    setState(() {
      numberController.text = "";
      nameController.text = "";
      colors = Colors.green;
    });
  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}