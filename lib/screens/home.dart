import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../component/productcard.dart';
import '../component/waitforApprove.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  final email;
  final pin;

  const HomePage({
    @required this.email,
    @required this.pin,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic approve;
  Map<String, dynamic> products = {};
  var pro;
  @override
  void initState() {
    super.initState();
    this.getusers();
    this.getProducts();
  }

  getusers() async {
    var url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      Map<String, dynamic> res = jsonDecode(response.body);
      res.forEach((key, value) async {
        if (widget.email == value["email"] && value['Aproved'] == true) {
          approve = value['Aproved'];
        }
      });
    });
  }

  var productUrl =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";

  Future getProducts() async {
    final response = await http.get(Uri.parse(productUrl));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      pro = resp;
      resp.asMap().forEach((index, element) {
        products[index.toString()] = element;
      });
      // print(pro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: approve.toString() == "true"
                ? Text("homePage")
                : Text(" Pending Aproval")),
        body: approve.toString() == "true"
            ? ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(widget.email),
                        ],
                      ),
                      
                     ProductCardView(  product: pro, )
                        
                    
                    ],
                  )
                ],
              )
            : Center(child: ApprovelMsg()));
  }
}
