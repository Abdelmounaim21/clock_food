import 'dart:async';

import 'package:clock_food/ScreensPage/Category.dart';
import 'package:clock_food/models/Products.dart';
import 'package:clock_food/ui/DetailProduct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DetailCategory extends StatefulWidget{

  final Products p ;
  final String c;



  DetailCategory(this.p,this.c);

  @override
  State<StatefulWidget> createState() => new _DetailCategoryState();

}
class _DetailCategoryState extends State<DetailCategory>{


  List<Products> listProducts = new List();
  StreamSubscription<Event> _onProductAddedSubscription;
  final productsReference =
  FirebaseDatabase.instance.reference().child('AllProducts');
  String productImage;
  @override
  void initState() {
    super.initState();
    final  cat = productsReference.orderByChild("category").equalTo(widget.c);
    listProducts = new List();
    _onProductAddedSubscription =
        cat.onChildAdded.listen(_onProductAdded);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clock Food'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: listProducts == null ? 0 : listProducts.length,
        itemBuilder: (BuildContext context, int index) {

          return  GestureDetector(
            onTap: (){
              _navigateToProductInformation(context, listProducts[index]);
            },
            child :Card(
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
                  Image.network(
                    listProducts[index].image,
                    height: 80,
                    width: 150,
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                  Text(
                    listProducts[index].name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Price :' + listProducts[index].price.toString() + 'DH',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Category :' + listProducts[index].category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                ],
              ),
            ),

          );

        },
      ),
    );
  }
  void _onProductAdded(Event event) {
    setState(() {
      listProducts.add(new Products.fromSnapShot(event.snapshot));
    });
  }
  void _navigateToProductInformation(BuildContext context,Products product)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailProduct(product)),
    );

  }
}


