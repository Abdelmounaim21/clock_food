import 'dart:async';
import 'package:clock_food/ui/DetailCategory.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clock_food/models/Products.dart';


class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

    String cat = "";
  int pos =0;

  List<Products> listProducts = new List();
  StreamSubscription<Event> _onProductAddedSubscription;
  final productsReference =
  FirebaseDatabase.instance.reference().child('Products').child('burger').child('burger ham');
  final productsReference2 =
  FirebaseDatabase.instance.reference().child('Products').child('drink').child('fraise drink');
    final productsReference3 =
    FirebaseDatabase.instance.reference().child('Products').child('pizza').child('pizza fromage');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("Products");


  @override
  void initState() {
    super.initState();
    listProducts = new List();
    _onProductAddedSubscription =
    productsReference.onChildAdded.listen(_onProductAdded);
    productsReference2.onChildAdded.listen(_onProductAdded);
    productsReference3.onChildAdded.listen(_onProductAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: ListView.builder(
          itemCount: listProducts == null ? 0 : listProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                _navigateToProductsOfCategory(context, listProducts[index],listProducts[index].category);
                pos = index;

              },
            child : Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: EdgeInsets.only(
                  top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
              color: Colors.black,
              child: new Column(
                children: <Widget>[
                  Image.network(
                    listProducts[index].image,
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                  Text(
                    listProducts[index].category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                ],
              ),

            ),
            );

          },
        ),
      ),

    );
  }
  void _onProductAdded(Event event) {
    setState(() {
      listProducts.add(new Products.fromSnapShot(event.snapshot));
    });
  }
  void _navigateToProductsOfCategory(BuildContext context,Products product,String c)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailCategory(product,c)),
    );

  }

}