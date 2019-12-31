import 'package:flutter/material.dart';
import 'dart:async';
import 'package:note_keeper/utils/database_helper.dart';
import 'package:note_keeper/models/note.dart';
import 'package:intl/intl.dart';

class NoteDetails extends StatefulWidget{

  final String appBarTitle;
  final Note note;
  NoteDetails(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState(this.note, this.appBarTitle);
  }
}

class NoteDetailsState extends State<NoteDetails> {

  static var _priorities = ['High', 'Low'];

  DatabaseHelper databaseHelper = new DatabaseHelper();

  String appbarTitle;
  Note note;

  NoteDetailsState(this.note, this.appbarTitle);
  TextStyle textStyle;
  var initial_value = 'Low';
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    descriptionController.text = note.date;
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appbarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            }
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: getListView(),
        ),
      )
    );
  }

  ListView getListView(){
    return ListView(
      children: <Widget>[
        ListTile(
          title: dropDownWidget(),
        ),

        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: getTextField(titleController, 'Title'),
        ),

        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: getTextField(descriptionController, 'Description'),
        ),

        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Save',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    setState(() {
                      debugPrint('Save button Clicked');
                      _save();
                    });
                  }
                ),
              ),
              Container(width: 5.0,),
              Expanded(
                child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Delete',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        debugPrint('Delete button Clicked');
                        _delete();
                      });
                    }
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  TextField getTextField(TextEditingController controller, String field){
    return TextField(
      controller: controller,
      style: textStyle,
      onChanged: (value) {
        debugPrint('Something changed in the $field text Fleld');
        if(field == 'Title'){
          updateTitle();
        } else if (field == 'Description'){
          updateDescription();
        }
      },
      decoration: InputDecoration(
        labelText: field,
        labelStyle: textStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  DropdownButton dropDownWidget(){
    return DropdownButton(
      items: _priorities.map((String dropdownStringItem) {
        return DropdownMenuItem<String> (
          value: dropdownStringItem,
          child: Text(dropdownStringItem),
        );
      }).toList(),
      style: textStyle,
      value: updatePriorityAsString(note.priority),
      onChanged: (value) {
        setState(() {
          debugPrint('User Selected $value');
          updatePriorityAsInt(value);
        });
      },
    );
  }

  //convert string priority to int
  void updatePriorityAsInt(String value) {
    switch(value){
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //convert int priority to string
  String updatePriorityAsString(int value) {
    String priority;
    switch(value){
      case 1:
        priority = _priorities[0];//high
        break;
      case 2:
        priority = _priorities[1];//low
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  //save to db
  void _save() async {

    debugPrint("coming to _save");
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if(note.id != null){  //update
      result = await databaseHelper.updateNote(note);
    }else {               //insert
      result = await databaseHelper.insertNote(note);
    }

//    if(result != 0){    //success
//      _showAlertDialog('Status', 'Note Saved Successfuly');
//    }else {             //failure
//      _showAlertDialog('Status', 'Problem Saving Note');
//    }
  }
  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }

  void _delete() async{

    moveToLastScreen();

    int result;
    if(note.id == null){  // new Entry
      _showAlertDialog('Status', 'No Note was Deleted');
      return;
    }else {               //valid if
      result = await databaseHelper.deleteNote(note.id);
    }

    if(result != 0){    //success
      _showAlertDialog('Status', 'Note Deleted Successfuly');
    }else {             //failure
      _showAlertDialog('Status', 'Problem Deleting Note');
    }
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }
}