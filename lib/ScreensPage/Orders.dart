import 'dart:async';
import 'package:clock_food/ScreensPage/Category.dart';
import 'package:clock_food/models/Orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clock_food/models/Products.dart';

class OrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _OrderPageState();
}

class _OrderPageState extends State<OrdersPage> {
  List<Orders> listOrder = new List();
  StreamSubscription<Event> _onProductAddedSubscription;
  final orderReference = FirebaseDatabase.instance
      .reference()
      .child('Orders')
      .child(FirebaseAuth.instance.currentUser.uid);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int sub = 0;
  int total = 0;
  int i = 1;
  @override
  void initState() {
    super.initState();
    listOrder = new List();
    _onProductAddedSubscription =
        orderReference.onChildAdded.listen(_onOrderAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: listOrder == null ? 0 : listOrder.length,
          itemBuilder: (BuildContext context, int index) {
            total = total + (int.parse(listOrder[index].totalPrice) * int.parse(listOrder[index].quantityOrdered) );

            return index != listOrder.length - 1 ?
            Row(
              children: [
                Expanded(
                  flex: 6,
                    child: Card(
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
                      color: Colors.black,
                      child: new Column(
                        children: <Widget>[
                          SizedBox(
                            height: 11.0,
                          ),
                          Text(
                            listOrder[index].nameProduct.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Total Price :' + listOrder[index].totalPrice + 'DH',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Quantity Ordered :' +
                                listOrder[index].quantityOrdered,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 11.0,
                          ),
                          /*index == listOrder.length - 1 ? Text(
                       'TOTAL PRICE PRODUCTS :'+total.toString()+'DH',
                     style: TextStyle(
                       color: Colors.amberAccent,
                       fontWeight: FontWeight.w900,
                     ),
                   ) :
                   Container(),
                  index == listOrder.length - 1 ? RaisedButton(
                      child: Text(
                        'Submit Command'
                      ),
                      onPressed: () => {

                  }) : Container()*/
                        ],
                      ),
                    )
                )

              ],
            )

                : index == listOrder.length - 1
                    ? Row(
                        children: [
                          Expanded(
                            flex: 6,
                              child: Card(
                                  elevation: 12.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 15.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 15.0),
                                  color: Colors.black,
                                  child: new Column(
                                      children: <Widget>[
                                    SizedBox(
                                      height: 11.0,
                                    ),
                                    Text(
                                      listOrder[listOrder.length - 1]
                                          .nameProduct
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      'Total Price :' +
                                          listOrder[listOrder.length - 1]
                                              .totalPrice +
                                          'DH',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      'Quantity Ordered :' +
                                          listOrder[listOrder.length - 1]
                                              .quantityOrdered,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                        SizedBox(
                                            height: 15.0
                                        ),

                                        Text(
                                          'TOTAL PRICE PRODUCTS : ' + total.toString() + ' DH',
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                                          margin: EdgeInsets.only(
                                              top: 15.0,
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 15.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Submit Your Order here',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.check_circle,color: Colors.green,),
                                                onPressed: () => {

                                                  FirebaseDatabase.instance
                                                      .reference()
                                                      .child('SubmittedOrders')
                                                      .child(_auth.currentUser.uid)
                                                      .set(
                                                      {
                                                        'etatOrder' : "submit order succesfully",
                                                        'uid' : _auth.currentUser.uid,
                                                      }
                                                  ).then((value){
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              "Order Submit Successfully",
                                                              style: TextStyle(
                                                                color: Colors.green,
                                                              ),
                                                            ),
                                                            content: Text('Thank Your For Your Order '),
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

                                                  })
                                                },

                                              ),
                                            ],
                                          ),
                                        ),





                                  ])
                              ),
                          ),


                        ],
                      )
                    : Container();
          },
        ),
      ),
    );
//    );
  }

  void _onOrderAdded(Event event) {
    setState(() {
      listOrder.add(new Orders.fromSnapShot(event.snapshot));
    });
  }
}
