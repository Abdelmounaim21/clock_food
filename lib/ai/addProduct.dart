import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  File _image;
  String _uploadedFileURL;


  TextEditingController _nameProduct = new TextEditingController();
  TextEditingController _priceProduct = new TextEditingController();
  TextEditingController _categoryProduct = new TextEditingController();

/*Future chooseFile() async {
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
     setState(() {
       _image = image;
     });
   });
 }  */

  /*Future uploadFile() async {
   StorageReference storageReference = FirebaseStorage.instance
       .ref()
       .child('chats/${Path.basename(_image.path)}}');
   StorageUploadTask uploadTask = storageReference.putFile(_image);
   await uploadTask.onComplete;
   print('File Uploaded');
   storageReference.getDownloadURL().then((fileURL) {
     setState(() {
       _uploadedFileURL = fileURL;
     });
   });
 }  */

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
              Text('Add Image'),
              SizedBox(
                height: 7.5,
              ),
              IconButton(
               icon: Icon(Icons.add_a_photo),
                onPressed: chooseFile,
              ),
              _image != null
                  ? Image.asset(
                _image.path,
                height: 150,
              ) : Container(height: 150.0,),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name Product',
                ),
                controller: _nameProduct,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                controller: _priceProduct,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                controller: _categoryProduct,
              ),
              SizedBox(
                height: 15.0,
              ),
             RaisedButton(
               child: Text('Save'),
                 onPressed: uploadFile),

            ],

          ),
        ),
      ),
    );
  }

  Future chooseFile() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
  
  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Products/${Path.basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;

    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });

      FirebaseDatabase.instance
          .reference()
          .child('Products')
          .child(_categoryProduct.text)
          .child(_nameProduct.text)
          .child(_nameProduct.text)
          .set(
          {
            'image': _uploadedFileURL,
            'name': _nameProduct.text,
            'price': _priceProduct.text,
            'category': _categoryProduct.text,
          });
          FirebaseDatabase.instance
              .reference()
              .child('AllProducts')
              .child(_nameProduct.text)
              .set(
          {
          'image': _uploadedFileURL,
          'name': _nameProduct.text,
          'price': _priceProduct.text,
          'category': _categoryProduct.text,

      }).then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Insertion Successfully",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                content: Text('Click OK to insert new item'),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      _nameProduct.text = '';
                      _priceProduct.text = '';
                      _categoryProduct.text = '';
                      Navigator.of(context).pop();
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
      print('info upload');
    });
  }

}
