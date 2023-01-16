import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../screens/cartPage.dart';

class SingleProductPage extends StatefulWidget {
  final productData;
  final cruser;
  int price;
  SingleProductPage({this.productData, this.cruser, required this.price});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  dynamic cartData;
  int _quantity = 1;
   DateTime today = DateTime.now();
  void incrementQuantity() {
    setState(() {
      _quantity++;
      widget.price += int.parse(widget.productData['price']);
    });
  }

  decrementQuantity() {
    setState(() {
      if (_quantity > 1 ||
          widget.price > int.parse(widget.productData['price'])) {
        _quantity--;
        widget.price -= int.parse(widget.productData['price']);
      }
    });
  }

  NavTocartPage(e) async {
    var url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.cruser[1]}/data.json";
    var res = await http.post(Uri.parse(url), body: json.encode(e)).then(
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => CartPage(data: e))));
  }

  NavToPlaceorder(e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {
   
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '\Rs${widget.price.toString()}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Spacer(),
                    FloatingActionButton.small(
                        child: Icon(
                            const IconData(0xf2fe, fontFamily: 'MaterialIcons'),
                            color: Colors.black),
                        backgroundColor: Colors.white,
                        onPressed: decrementQuantity),
                    SizedBox(
                        width: 30,
                        child: Center(child: Text(_quantity.toString()))),
                    FloatingActionButton.small(
                        child: Icon(Icons.add, color: Colors.black87),
                        backgroundColor: Colors.white,
                        onPressed: incrementQuantity)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => NavTocartPage(cartData = {
                            "date": '${today.day}-${today.month}-${today.year}',
                            "email": widget.cruser[0],
                            "uuid": widget.cruser[1],
                            "name": widget.productData["name"],
                            "price": widget.price,
                            "productId": widget.productData["productID"],
                            "quantity": _quantity,
                            "image":widget.productData["image1"]
                          }),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 140,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => NavToPlaceorder(cartData = {
                            "date": '${today.day}-${today.month}-${today.year}',
                            "email": widget.cruser[0],
                            "uuid": widget.cruser[1],
                            "name": widget.productData["name"],
                            "price": widget.price,
                            "productId": widget.productData["productID"],
                            "quantity": _quantity,
                            "image":widget.productData["image1"]
                          }),
                          child: Text(
                            'Place Order',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
