
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Clock Food'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Full Name', icon: Icon(Icons.person_rounded)),
                controller: _name,

              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Address - Ville',
                    icon: Icon(Icons.location_city)),
                controller: _address,

              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tel',
                  icon: Icon(Icons.phone),
                ),
                controller: _phone,
              ),
              SizedBox(
                height: 15.0,
              ),
               TextField(

                  decoration: InputDecoration(
                      labelText: 'Password', icon: Icon(Icons.vpn_key)),
                  controller: _passwordController,
                 keyboardType: TextInputType.visiblePassword,

              ),


              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                child: Text('Register'),
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((singedUser) {
                    FirebaseDatabase.instance
                        .reference()
                        .child('users')
                        .child(singedUser.user.uid)
                        .child(singedUser.user.uid)
                        .set({
                      'name': _name.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'address': _address.text,
                      'phone': _phone.text,
                      'isLogin' : false
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Inscription Successfully",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            content: Text('Click OK to go in Login Page'),
                            actions: [
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                },
                              )
                            ],
                          );
                        });
                  }).catchError((e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(e.message),
                            actions: [
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                child: Text('Already have an account?'),
                textColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );

  }
}

