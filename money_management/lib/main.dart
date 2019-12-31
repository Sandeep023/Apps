import 'package:flutter/material.dart';
import 'package:money_management/screens/transactions_list.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Money Manager",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: TransactionsList(),
    );
  }

  Widget getWidget() {
    Future<bool> isAuthenticated = getAuthenticate();
    isAuthenticated.then((value){
      if(value){
        return TransactionsList();
      } else {
        return getWidget();
      }
    });
  }

  Future<bool> getAuthenticate() async{
    var localAuth = new LocalAuthentication();
    bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please Authenticate Yourself'
    );
    return didAuthenticate;
  }

}