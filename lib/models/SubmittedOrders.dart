import 'package:firebase_database/firebase_database.dart';

class SubmittedOrders{
  String _etatOrder;
  String _uid;

  SubmittedOrders(this._etatOrder, this._uid);

  String get uid => _uid;

  String get etatOrder => _etatOrder;

  SubmittedOrders.map(dynamic obj){
    this._etatOrder = obj['etatOrder'];
    this._uid = obj['uid'];
  }

  SubmittedOrders.fromSnapshot(DataSnapshot snapshot){
    _etatOrder = snapshot.value['etatOrder'];
    _uid = snapshot.value['uid'];
  }
}
