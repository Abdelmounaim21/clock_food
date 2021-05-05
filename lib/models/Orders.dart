import 'package:firebase_database/firebase_database.dart';

class Orders{
  String _nameProduct;
  String _totalPrice;
  String _nameUser;
  String _addressUser;
  String _telUser;
  String _quantityOrdered;



  Orders(this._nameProduct, this._totalPrice, this._nameUser,
      this._addressUser, this._telUser,this._quantityOrdered);

  Orders.map(dynamic obj){
    this._nameProduct = obj['nameProduct'];
    this._totalPrice = obj['totalPrice'];
    this._nameUser = obj['nameUser'];
    this._addressUser = obj['addressUser'];
    this._telUser = obj['telUser'];
    this._quantityOrdered = obj['quantityOrdered'];
  }


  String get nameProduct => _nameProduct;

  String get totalPrice => _totalPrice;

  String get nameUser => _nameUser;

  String get addressUser => _addressUser;

  String get telUser => _telUser;

  String get quantityOrdered => _quantityOrdered;

  Orders.fromSnapShot(DataSnapshot snapshot){
    _nameProduct = snapshot.value['nameProduct'];
    _totalPrice = snapshot.value['totalPrice'];
    _nameUser = snapshot.value['nameUser'];
    _addressUser = snapshot.value['addressUser'];
    _telUser = snapshot.value['telUser'];
    _quantityOrdered = snapshot.value['quantityOrdered'];
  }


}
