import 'dart:async';
import 'package:clock_food/ScreensPage/Category.dart';
import 'package:clock_food/ScreensPage/Home.dart';
import 'package:clock_food/ScreensPage/Orders.dart';
import 'package:clock_food/main.dart';
import 'package:clock_food/models/Users.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _email = '';

  var _currentIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription<Event> _onUserAddedSubscription;
  final productsReference =
      FirebaseDatabase.instance.reference().child('Products');
  final userNameReference = FirebaseDatabase.instance
      .reference()
      .child('users')
      .child(FirebaseAuth.instance.currentUser.uid);

  final dbRef = FirebaseDatabase.instance.reference().child("Products");

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      // _name = userNameReference.child('name');
      _email = user.email;
      print('operation valid');
    }
  }

  List<Users> listUsers = new List();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    listUsers = new List();
    _onUserAddedSubscription =
        userNameReference.onChildAdded.listen(_onUserAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Clock Food'),
        actions: [
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                FirebaseDatabase.instance.reference().child('users')
                    .child(FirebaseAuth.instance.currentUser.uid)
                    .child(FirebaseAuth.instance.currentUser.uid)
                    .update({
                  'isLogin' : false,
                });
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }).catchError((e) {
                  print(e);
                });
              }),
        ],
      ),
      body: _currentIndex == 0
          ? HomePage()
          : _currentIndex == 1
              ? CategoryPage()
              : _currentIndex == 2
                  ? OrdersPage()
                  : Container(),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.white,
            ),
            activeIcon: new Icon(
              Icons.home,
              color: Colors.red,
            ),
            // ignore: deprecated_member_use
            title: new Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          new BottomNavigationBarItem(
            // ignore: deprecated_member_use
            icon: new Icon(Icons.category, color: Colors.white),
            activeIcon: new Icon(Icons.category, color: Colors.red),
            // ignore: deprecated_member_use
            title: new Text(
              'Category',
              style: TextStyle(color: Colors.white),
            ),
          ),
          new BottomNavigationBarItem(
              // ignore: deprecated_member_use
              icon: new Icon(Icons.add, color: Colors.white),
              activeIcon: new Icon(Icons.add, color: Colors.red),
              // ignore: deprecated_member_use
              title: new Text(
                'orders',
                style: TextStyle(color: Colors.white),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },

        //fixed for show over 3 navigation item
        type: BottomNavigationBarType.fixed,
      ),
      drawer: new Drawer(
        child: Container(
          color: Colors.deepPurpleAccent,
          padding: EdgeInsets.only(left: 5.0, top: 50.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Icon(
                Icons.account_circle,
                size: 100.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 400.0,
              child: ListView.builder(
                  itemCount: listUsers == null ? 0 : listUsers.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Text(
                          '${listUsers[position].fullName}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${listUsers[position].email}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        FlatButton(
                          child: Text(
                            'Setting',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pushNamed('/setting');
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: (){ showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "About Us",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  content: Text('Welcome to Clock Express, your number one source for all things [product]. We\^re dedicated to giving you the very best of'
                                      'with a focus on [store characteristic 1], [store characteristic 2], [store characteristic 3].'
                                      'Founded in [year] by [founder name], Clock Express has come a long way from its beginnings in [starting location]. When [founder name] first started out, [his/her/their] passion for [brand message - e.g. "eco-friendly cleaning products"] drove them to [action: quit day job, do tons of research, etc.] so that Clock Express can offer you [competitive differentiator - e.g. the worlds most advanced toothbrush]. We now serve customers all over [place - town, country, the world], and are thrilled that were able to turn our passion into [my/our] own website.'
                                      '[I/we] hope you enjoy [my/our] products as much as [I/we] enjoy offering them to you. If you have any questions or comments, please dont hesitate to contact [me/us].'
                                      'Sincerely'
                                      'founder name'),
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
                          }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          child: Text(
                            'Terms And Policy',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: (){ showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Terms And Policy",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  content: Text('Welcome to Clock Express, your number one source for all things [product]. We\^re dedicated to giving you the very best of'
                                      'with a focus on [store characteristic 1], [store characteristic 2], [store characteristic 3].'
                                      'Founded in [year] by [founder name], Clock Express has come a long way from its beginnings in [starting location]. When [founder name] first started out, [his/her/their] passion for [brand message - e.g. "eco-friendly cleaning products"] drove them to [action: quit day job, do tons of research, etc.] so that Clock Express can offer you [competitive differentiator - e.g. the worlds most advanced toothbrush]. We now serve customers all over [place - town, country, the world], and are thrilled that were able to turn our passion into [my/our] own website.'
                                      '[I/we] hope you enjoy [my/our] products as much as [I/we] enjoy offering them to you. If you have any questions or comments, please dont hesitate to contact [me/us].'
                                      'Sincerely'
                                      'founder name'),
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
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }

  void _onUserAdded(Event event) {
    setState(() {
      listUsers.add(new Users.fromSnapShot(event.snapshot));
    });
  }
}
