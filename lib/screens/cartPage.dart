import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final data ;
  CartPage({this.data});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

 

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      body: Center(child: Text("cart")),
    );
  }
}
