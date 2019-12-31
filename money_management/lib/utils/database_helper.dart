import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:money_management/models/transaction.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tableTransactions ='transactions';
  String colId = 'id';
  String colMsgId ='msg_id';
  String colFrom = 'source';
  String colTo = 'destination';
  String colAction = 'action';
  String colAmount = 'amount';
  String colDate = 'day';


  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'transaction.db';

    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  //Create db
  void _createDb(Database db, int newVersion) async {
    String cmd = 'CREATE TABLE $tableTransactions ($colMsgId INTEGER, $colId INTEGER PRIMARY KEY AUTOINCREMENT, $colFrom TEXT, '
        '$colTo TEXT, $colAction TEXT, $colAmount TEXT, $colDate TEXT)';
    await db.execute(cmd);
  }

  //Fetch all
  Future<List<Map<String, dynamic>>> getTransactionsMapList() async {
    Database db = await this.database;
    var result = await db.query(tableTransactions);
    return result;
  }

  //Insert Operation
  Future<int> insertNote(Transactions t) async{
    Database db = await this.database;
    var result = await db.insert(tableTransactions, t.toMap());
    return result;
  }

  //Insert Operation
  Future<List<Map<String, dynamic>>> maxMsgId() async{
    Database db = await this.database;
    var result = await db.rawQuery("SELECT MAX(msg_id) FROM transactions");
    return result;
  }

  //Update Operation
  Future<int> updateNote(Transactions tr) async {
    Database db = await this.database;
    var result = await db.update(tableTransactions, tr.toMap(), where: '$colId = ?', whereArgs: [tr.id]);
    return result;
  }

  //Delete Operation
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableTransactions WHERE $colId = $id');
    return result;
  }

  //Count of entries in table
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tableTransactions');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //convert Map list to Node list
  Future<List<Transactions>> getTransactionsList() async {
    var transactionsMapList = await getTransactionsMapList();
    int count = transactionsMapList.length;
    List<Transactions> transactionsList = List<Transactions>();

    for (int i = 0; i < count; i++) {
      transactionsList.add(Transactions.fromMapObject(transactionsMapList[i]));
    }
    return transactionsList;
  }

}