class Transactions{
  int _id;
  int _msg_id;
  String _source;
  String _destination;
  String _action;
  String _amount;
  String _day;

  Transactions(this._msg_id, this._source, this._destination, this._action, this._amount, this._day);

  Transactions.withId(this._id, this._msg_id, this._source, this._destination, this._action, this._amount, this._day);

  int get id => _id;
  int get msg_id => _msg_id;
  String get source => _source;
  String get destination => _destination;
  String get action => _action;
  String get amount => _amount;
  String get day => _day;

  set msg_id(int msg){
    this.msg_id = msg;
  }
  set source(String newsource){
    if(newsource.length < 255){
      this._source = newsource;
    }
  }
  set destination(String newdestination){
    if(newdestination.length < 255){
      this._destination = newdestination;
    }
  }
  set action(String newAction){
    if(newAction.length < 255){
      this._action = newAction;
    }
  }
  set amount(String newAmount){
    if(newAmount.length < 255){
      this._amount = newAmount;
    }
  }
  set day(String newday){
    if(newday.length < 255){
      this._source = newday;
    }
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    if(id != null)
      map['id'] = _id;

    map['msg_id'] = _msg_id;
    map['source'] = _source;
    map['destination'] = _destination;
    map['action'] = _action;
    map['amount'] = _amount;
    map['day'] = _day;

    return map;
  }

  Transactions.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._msg_id = map['msg_id'];
    this._source = map['source'];
    this._destination = map['destination'];
    this._action = map['action'];
    this._amount = map['amount'];
    this._day = map['day'];
  }

}