import 'package:firebase_database/firebase_database.dart';

class Users{
  String _fullName;
  String _email;
  String _address;
  String _tel;
  String _password;
  bool _isLogin;


  Users(this._fullName, this._email, this._address, this._tel, this._password,this._isLogin);

  Users.map(dynamic obj){
    this._fullName = obj['full name'];
    this._email = obj['email'];
    this._address = obj['address'];
    this._tel = obj['tel'];
    this._password = obj['password'];
    this._isLogin = obj['isLogin'];
  }

  String get fullName => _fullName;
  String get email => _email;
  String get address => _address;
  String get tel => _tel;
  String get password => _password;
  bool get isLogin => _isLogin;



  Users.fromSnapShot(DataSnapshot snapshot){
    _fullName = snapshot.value['name'];
    _email = snapshot.value['email'];
    _address = snapshot.value['address'];
    _tel = snapshot.value['tel'];
    _password = snapshot.value['password'];
    _isLogin = snapshot.value['isLogin'];
  }
}
