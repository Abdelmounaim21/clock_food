import 'package:clock_food/ui/MainScreen.dart';
import 'package:clock_food/ui/LoginPage.dart';
import 'package:clock_food/ui/RegisterPage.dart';
import 'package:clock_food/ui/SettingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:clock_food/main.dart';
import 'ai/addProduct.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
/*
final ref =
  FirebaseDatabase.instance.reference()
  .child('users')
  .child(FirebaseAuth.instance.currentUser.uid)
  .child(FirebaseAuth.instance.currentUser.uid);
*/


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        // ignore: unrelated_type_equality_checks
        home:  new LoginPage(),
        routes: <String , WidgetBuilder>{
          '/login' : (BuildContext context) => new LoginPage(),
          '/register' : (BuildContext context) => new RegisterPage(),
          '/home' : (BuildContext context) => new Home(),
          '/addcategory' : (BuildContext context) => new AddProduct(),
          '/setting' : (BuildContext context) => new SettingsPage(),

        }

    );

  }
}
