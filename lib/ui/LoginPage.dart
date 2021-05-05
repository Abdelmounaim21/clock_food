import 'package:clock_food/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Clock Food'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email',icon: Icon(Icons.email)),
              controller: _emailController,
            ),
            SizedBox(height: 15.0,),

            TextField(
              decoration: InputDecoration(labelText: 'Password',icon: Icon(Icons.vpn_key)),
              controller: _passwordController,
            ),
            SizedBox(height: 15.0,),
            FlatButton(
              child: Text('Login' ),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: (){
                if(_emailController.text.trim() == 'admin@gmail.ma' && _passwordController.text == 'admin1'){
                  Navigator.of(context).pushNamed('/addcategory');
                }else{
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text.trim(), password: _passwordController.text
                  ).then((user){
                    FirebaseDatabase.instance.reference().child('users')
                        .child(FirebaseAuth.instance.currentUser.uid)
                        .child(FirebaseAuth.instance.currentUser.uid)
                        .update({
                      'isLogin' : true,
                    });

                    Navigator.of(context).pushReplacementNamed('/home');
                  }).catchError((e){
                    print(e);
                  });
                }
              },
            ),
            SizedBox(height: 15.0,),
            FlatButton(
              child: Text('Don\'t  have an account?'),
              textColor: Colors.blueAccent,
              onPressed: (){
                Navigator.of(context).pushNamed('/register');
              },
            ),
          ],
        ),
      ),
    );
  }

}
