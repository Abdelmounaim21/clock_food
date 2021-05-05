import 'dart:ffi';

import 'package:clock_food/models/Products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  final Products product;

  DetailProduct(this.product);

  @override
  State<StatefulWidget> createState() => new _DetailProductState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
int _counter = 1;
final userReference = FirebaseDatabase.instance.reference().child('Products');

class _DetailProductState extends State<DetailProduct> {
  String productImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productImage = widget.product.image;
    print(productImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock Food'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: EdgeInsets.only(
                  top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
              color: Colors.black,
              child: Column(
                children: [
                  productImage == ''
                      ? Text('No Image')
                      : Image.network(
                          productImage + '?alt=media',
                          height: 160.0,
                          width: 120.0,
                        ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    widget.product.name.toUpperCase(),
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                    widget.product.price.toString() + '  DH',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                    widget.product.category.toUpperCase(),
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new IconButton(
                        icon: new Icon(Icons.remove,color: Colors.white,),
                        highlightColor: Colors.green,
                        onPressed: () {
                          _removeProduct();
                        },
                      ),
                      new Text(
                        '$_counter',
                        style: TextStyle(
                          color: Colors.white,
                        fontSize: 25.0
                        ),
                      ),
                      new IconButton(
                        icon: new Icon(Icons.add,color: Colors.white,),
                        highlightColor: Colors.green,
                        onPressed: () {
                          _addProduct();
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Add Item in Orders',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: _setOrder),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setOrder() {
    setState(() {
      int res = int.parse(widget.product.price) * _counter;
      FirebaseDatabase.instance
          .reference()
          .child('Orders')
          .child(_auth.currentUser.uid)
          .child(widget.product.name)
          .set({
        'nameProduct': widget.product.name,
        'totalPrice': res.toString(),
        'nameUser': _auth.currentUser.uid,
        'addressUser': _auth.currentUser.uid,
        'telUser': _auth.currentUser.uid,
        'quantityOrdered': _counter.toString(),
      }).then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Done !",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                content: Text('Go to Orders Page to Confirm you Order . '),
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
    });
  }

  _addProduct() {
    setState(() {
      _counter++;
    });
  }

  _removeProduct() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }
}
