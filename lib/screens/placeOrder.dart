import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  final orderData;
  PlaceOrder({this.orderData});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  dynamic url;
  dynamic cartproducts;
  dynamic keysdata;

  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.orderData['uuid']}.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      if (resp != null) {
        cartproducts = resp;
      } else {}
    });
    // data.map((e) => print(e[' name'])).toList();
  }

@override
  void initState() {
    super.initState();
    this.getusersdata();
  }

  @override
  Widget build(BuildContext context) {
    print(cartproducts);
    return Scaffold(body: Container());
  }
}
