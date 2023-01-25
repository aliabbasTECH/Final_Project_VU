import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

 
 


class _CategoriesListState extends State<CategoriesList> {
dynamic crUser;
  // dynamic approve;
  // dynamic username;
  // dynamic camount;
  // Map<String, dynamic> products = {};
  var pro;
  @override
  void initState() {
    super.initState();
    this.getProducts();
  }

  var productUrl =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";

  Future getProducts() async {
    final response = await http.get(Uri.parse(productUrl));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      pro = resp;
      resp.asMap().forEach((index, element) {
        print(pro[index]['category']);
      });
      
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 100,
            color: Colors.red,
          ),
          Container(
            width: 100,
            color: Colors.blue,
          ),
          Container(
            width: 100,
            color: Colors.green,
          ),
          Container(
            width: 100,
            color: Colors.yellow,
          ),
          Container(
            width: 100,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
