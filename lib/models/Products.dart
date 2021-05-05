import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class Products{
  String _category;
  String _image;
  String _name;
  String _price;

  Products(this._category, this._image, this._name, this._price);

  Products.map(dynamic obj){
    this._category = obj['category'];
    this._image = obj['image'];
    this._name = obj['name'];
    this._price = obj['price'];
  }

  String get category => _category;
  String get name => _name;
  String get price => _price;
  String get image => _image;


  Products.fromSnapShot(DataSnapshot snapshot){
    _name = snapshot.value['name'];
    _category = snapshot.value['category'];
    _price = snapshot.value['price'];
    _image = snapshot.value['image'];
  }
}
