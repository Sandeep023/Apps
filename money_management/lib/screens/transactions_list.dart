import 'package:flutter/material.dart';
import 'package:money_management/models/transaction.dart';
import 'package:sms/sms.dart';
import 'package:money_management/utils/database_helper.dart';
import 'package:local_auth/local_auth.dart';

class TransactionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TransactionListState();
  }

}

class _TransactionListState extends State<TransactionsList>{
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Transactions> transaction;
  List<SmsMessage> message;
  SmsQuery query = new SmsQuery();
  int count = 0;
  int maxId = 0;
  List<Transactions> msgTransactions;
  List<String> mss;

  @override
  void initState() {
    // TODO: implement initState
    transaction = new List();
    message = new List();
    msgTransactions = new List();
    mss = new List();
    Future<List<Transactions>> list =  databaseHelper.getTransactionsList();
    list.then((value){
      int max = 0;
      for(Transactions t in value){
        if(t.msg_id > max){
          max = t.msg_id;
        }
      }
      if(value.length == 0){
        getMessages();
      } else {
        setState(() {
          transaction = value;
          count = value.length;
          maxId = max;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text("List of All Transactions"),
      ),
      body: getSMSListViewListTile(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FABPressed");
          getMessages();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void getMessages() {
    Future<List<SmsMessage>> messages = query.getAllSms;
    messages.then((value) {
      message = value;
      saveData();
    });
  }

  void saveData(){
    String from;
    String to;
    String action;
    String amount;
    String date;

    for(SmsMessage m in message){
      if(m.address.contains("HDFC") && maxId < m.id) {
        String body = m.body;

        if(body.startsWith("UPDATE")){
          var words = body.split(" ");
          date = words[8];
          amount = words[2];
          action = words[3];
          if(action == "deposited") {
            from = words[10];
            to = "me";
          }
          else if (action == "debited"){
            to = words[10];
            from = "me";
          }
          msgTransactions.add(Transactions(m.id, from, to, action, amount, date));
          mss.add(body);
        }

        else if(body.startsWith("Rs")){
          var words = body.split(" ");
          amount = words[1];
          action = words[2];
          date = words[7];
          if(action == "credited") {
            if (words[9] == "VPA") {
              from = words[10];
              to = "me";
            }
            else if(words[9] == "a/c"){
              if(words[10].startsWith("**"))
                from = words[10];
              else
                from = words[13];
              to = "me";
            }
          }
          else if(action == "debited") {
            if (words[9] == "VPA") {
              to = words[10];
              from = "me";
            }
            else if(words[9] == "a/c"){
              if(words[10].startsWith("**"))
                to = words[10];
              else
                to = words[13];
              from = "me";
            }
          }
          msgTransactions.add(Transactions(m.id, from, to, action, amount, date));
          mss.add(body);
        }
        
        else if(body.startsWith("ALERT")) {
          debugPrint(body);
          var words = body.split(" ");
          amount = words[2];
          action = "debited";
          from = "me";
          if(words[9] != "on") {
            to = words[8] + " " + words[9];
            if (words[10].startsWith("RES")) {
              date = words[12].split(".")[0];
              to = to + " " + words[10];
            } else {
              date = words[11].split(".")[0];
            }
          } else {
            date = words[10].split(".")[0];
            to = words[8];
          }
          msgTransactions.add(Transactions(m.id, from, to, action, amount, date));
          mss.add(body);
        }
      }
    }
    _save();
  }

  String getUpikey(String body){
    String key = "";
    var words = body.split(" ");
    for(int i=0; i<words.length; i++){
      if(words[i].contains("upi")) {
        if(words[i].contains("@") && words[i].indexOf("upi") == words[i].lastIndexOf("upi")) {
          key = words[i + 3].substring(0, 12);
        }else if(words[i].contains("upirb")){
          var letters = words[i].split("-");
          key = letters[1];
        }else if(words[i].length == 4){
          for(int j=i+3; j<words.length; j++){
            if(words[j] != "" && words[j].length >= 12){
              key = words[j].substring(0, 12);
              break;
            }
          }
        }else if(words[i].contains("@") && words[i].indexOf("upi") != words[i].lastIndexOf("upi")){
          key = words[i].substring(words[i].indexOf("pay")+4, words[i].indexOf("pay")+16);
        }
      }
    }
    return key;
  }

  void deleteDuplicates() {
    int length = msgTransactions.length;
    debugPrint(length.toString());
    List<String> keys = new List();
    for(int i=0; i<length; i++){
      if(mss[i].toLowerCase().contains("upi")){
        keys.add(getUpikey(mss[i].toLowerCase()));
      } else {
        keys.add("");
      }
    }
    for(int i=length-1; i>=0; i--){
      for(int j=i-1; j>=0; j--){
        if(keys[i] != "" && keys[i] == keys[j]){
          debugPrint("***" + i.toString());
          msgTransactions.removeAt(i);
        }
      }
    }
    debugPrint(transaction.length.toString());
  }

  void _save() async{
    deleteDuplicates();
    for(Transactions tr in msgTransactions) {
      int result = await databaseHelper.insertNote(tr);
    }
    changeState();

  }

  void changeState() async{
    List<Transactions> list = await databaseHelper.getTransactionsList();
    int max = 0;
    for(Transactions t in list){
      if(t.msg_id > max){
        max = t.msg_id;
      }
    }
    setState(() {
      this.maxId = max;
      this.transaction = list;
      this.count = list.length;
    });
  }

  ListView getSMSListViewCards() {

    TextStyle textStyle = Theme.of(context).textTheme.headline;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: getColor(transaction[position].action),
            child: getIcon(transaction[position].action),
          ),
          title: getTitleCards(transaction[position], textStyle),
          trailing: GestureDetector(
            child: Icon(Icons.delete, color: Colors.grey,),
            onTap: () {
              debugPrint("del");
            },
          ),
        );
      },
    );

  }

  ListView getSMSListViewListTile(){

    TextStyle textStyle = Theme.of(context).textTheme.headline;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          elevation: 2.0,
          child: ListTile(
            leading: getIcon(transaction[position].action),
            title: getTitle(transaction[position], textStyle),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                debugPrint("del");
                _delete();
              },
            ),
            onTap: () {
              debugPrint("Tile Pressed");
              _showpopup(position, context);
            },
          ),
        );
      },
    );
  }

  void _showpopup(int position, BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("Message"),
      content: Text(mss[position]),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }

  void _delete() async{
    try{
      debugPrint("delete");
      var localAuth = new LocalAuthentication();

      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please Authenticate Yourself'
      );
      debugPrint(didAuthenticate.toString());
    } catch(e){
      debugPrint(e.toString());
    }
  }

  Color getColor(String action){
    if(action == "deposited" || action == "credited"){
      return Colors.green;
    }
    else if(action == "debited"){
      return Colors.red;
    }
    return Colors.yellow;
  }

  Icon getIcon(String action){
    if(action == "deposited" || action == "credited"){
      return Icon(Icons.keyboard_arrow_right, color: Colors.green,);
    }
    else if(action == "debited"){
      return Icon(Icons.keyboard_arrow_left, color: Colors.red,);
    }
    return Icon(Icons.home);
  }

  Column getInsideTitle(String text, String heading){
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return Column(
      children: <Widget>[

        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            heading,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
        ),

        Divider(
          indent: 10.0,
        ),

        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),

      ],
    );
  }

  Row getTitleCards(Transactions tr, TextStyle textStyle){
    String text;
    String heading;

    if(tr.action == "debited"){
      heading = "TO";
      text = tr.destination;
    } else {
      heading = "FROM";
      text = tr.source;
    }
    return Row(
      children: <Widget>[

        Expanded(
          child: Card(
            elevation: 2.0,
            child: SizedBox(
              child: getInsideTitle(text, heading),
            ),
          ),
        ),

        Container(
          width: 5.0,
        ),

        Expanded(
          child: Card(
            elevation: 2.0,
            child: SizedBox(
              child: getInsideTitle(tr.amount, "Amount")
            ),
          ),
        ),

      ],
    );
  }

  ListTile getTitle(Transactions tr, TextStyle textStyle){

    String text;
    String heading;

    if(tr.action == "debited"){
      heading = "TO";
      text = tr.destination;
    } else {
      heading = "FROM";
      text = tr.source;
    }

    return ListTile(
      title: Text(heading + " : " + text),
      subtitle: Text(tr.amount + " on " + tr.day),
    );
  }

}