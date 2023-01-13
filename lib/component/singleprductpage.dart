import 'package:flutter/material.dart';

import '../screens/cartPage.dart';

class SingleProductPage extends StatefulWidget {
  final productData;
  final cruser;

  SingleProductPage({this.productData, this.cruser});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  List cartData = [];

  NavTocartPage(e) {
    print(e);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartPage(data: e)));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cruser);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network('${widget.productData["image1"]}'),
              ),
              SizedBox(height: 20),
              Text(
                '${widget.productData["name"]}',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              Text(
                '\Rs${widget.productData["price"]}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => NavTocartPage(cartData = [
                    widget.cruser[0],
                    widget.cruser[1],
                    widget.productData["name"],
                    widget.productData["price"],
                    widget.productData["productID"]
                  ]),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
