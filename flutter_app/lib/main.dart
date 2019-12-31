import 'package:flutter/material.dart';
import './app_screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Basic Principal Calculater",
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  final _minumPadding = 5.0;
  var _currentSelectedOption = '';
  var _displyText = '';

  @override
  void initState(){
    super.initState();
    _currentSelectedOption = _currencies[0];
  }

  TextEditingController principalController = new TextEditingController();
  TextEditingController roiController = new TextEditingController();
  TextEditingController termController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    TextStyle errorstyle = TextStyle(
      color: Colors.yellowAccent,
      fontSize: 15.0,
    );
    // TODO: implement build
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Sinple Intrest Calculater"),
      ),

      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(_minumPadding * 2),
          child: ListView(
            children: <Widget>[
              imageWidth(),

              Padding(
                padding: EdgeInsets.only(top: _minumPadding, bottom: _minumPadding),
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value) {
                    if(value.isEmpty)
                      return "Please enter Principal Amount";
                    if(double.tryParse(value) == null){
                      return "Enter Valid Principal Amount";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Principle",
                    hintText: "Enter Your Principle Here eg : 12000",
                    labelStyle: textStyle,
                    errorStyle: errorstyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(_minumPadding)
                    )
                  ),
                )
              ),

              Padding(
                padding: EdgeInsets.only(top: _minumPadding, bottom: _minumPadding),
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value) {
                    if(value.isEmpty)
                      return "Please enter Principal Amount";
                    if(double.tryParse(value) == null){
                      return "Enter Valid Principal Amount";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "in Percent",
                    labelStyle: textStyle,
                    errorStyle: errorstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minumPadding)
                    )
                  ),
                )
              ),

              Padding(
                padding: EdgeInsets.only(top: _minumPadding, bottom: _minumPadding),
                child:Row(
                  children: <Widget>[
                    Expanded(child:TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value) {
                        if(value.isEmpty)
                          return "Please enter Principal Amount";
                        if(double.tryParse(value) == null){
                          return "Enter Valid Principal Amount";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Time in years",
                          labelStyle: textStyle,
                          errorStyle: errorstyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(_minumPadding)
                          )
                      ),
                    )),

                    Container(width: _minumPadding*5,),

                    Expanded(child:DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentSelectedOption,
                      onChanged: (String newValueSelected) {
                        _onDropdowmChanged(newValueSelected);
                      },

                    )),

                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.only(top: _minumPadding, bottom: _minumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Calculate', textScaleFactor: 1.5,),
                        onPressed: () {
                          setState(() {
                            if(formKey.currentState.validate())
                              this._displyText = _calculateTotalReturns();
                          });
                        }
                      )
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Reset', textScaleFactor: 1.5,),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        }
                      )
                    )
                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.only(top: _minumPadding, bottom: _minumPadding),
                child: Text(this._displyText, style: textStyle,),
              )

            ],
          ),
        )
      ),
    );
  }

  Widget imageWidth() {
    AssetImage assetImage = AssetImage('images/Kajal.jpg');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    return Container(child: image, margin: EdgeInsets.all(_minumPadding * 10),);
  }

  void _onDropdowmChanged(String newValue){
    setState(() {
      this._currentSelectedOption = newValue;
    });
  }

  String _calculateTotalReturns(){
    double principle = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principle + (principle * roi * term) / 100;

    String result = 'After $term years, your investment will be worth $total $_currentSelectedOption';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    _displyText = '';
    _currentSelectedOption = _currencies[0];
  }

}








class FavoriteCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";
  var _currencies = ['Rupees', 'Dollar', 'Pounds', 'Others'];
  var _currentItemSelected = 'Rupees';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful App Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  this._currentItemSelected = newValueSelected;
                });
              },
              value: _currentItemSelected,
            ),
            Text(
              "Your Favorite City is $nameCity",
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

}





void showSnackBar(BuildContext context, String element) {
  var snackBar = new SnackBar(
    content: Text(element),
    action: SnackBarAction(
      label: "UNDO",
      onPressed: () {
        debugPrint("Performing dummy UNDO function");
      }
    ),
  );
  
  Scaffold.of(context).showSnackBar(snackBar);
}

List<String> getListElements() {
  var items = List<String>.generate(1000, (counter) => "Item $counter");
  return items;
}

Widget buildListView() {

  var listElements = getListElements();

  var listView = ListView.builder(
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.arrow_right),
        title: Text(listElements[index]),
        onTap: () {
          showSnackBar(context, listElements[index]);
        },
      );
    }
  );

  return listView;
}

Widget getListView() {

  var listView = ListView(
    children: <Widget>[

      ListTile(
        leading: Icon(Icons.landscape),
        title: Text("LandScape"),
        subtitle: Text("Beautiful View"),
        trailing: Icon(Icons.wb_sunny),
        onTap: () {
          debugPrint("Tile Tapped");
        },
      ),

      ListTile(
        leading: Icon(Icons.laptop_chromebook),
        title: Text("Windows"),
      ),

      ListTile(
        leading: Icon(Icons.phone),
        title: Text("Phone"),
      ),

    ],
  );

  return listView;

}



//void main(){
//  runApp(MaterialApp(
//    title: "Exploring UI Widgets",
//    home: Scaffold(
//      appBar: AppBar(
//        title: Text("Long List Widgets"),
//      ),
//      body: buildListView(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          debugPrint("floating button Pressed");
//        },
//        child: Icon(Icons.add),
//        tooltip: "Add one more Item",
//      ),
//    ),
//  ));
//}