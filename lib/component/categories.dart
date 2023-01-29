import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'categoriesproducts.dart';

class CategoriesList extends StatefulWidget {
  final product;
  final cUser;
  const CategoriesList({this.product, this.cUser});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  dynamic crUser;
dynamic category;
  var pro;
  List catvoislist = [];
  @override
  void initState() {
    super.initState();
    // this.getProducts();
  }

  var productUrl =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";

  Future getProducts() async {
    final response = await http.get(Uri.parse(productUrl));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      pro = resp;
      pro.asMap().forEach((index, element) {
        var list = pro[index];
        if (list['category'] == 'BAKERY') {
          catvoislist.add(list);
        }
      });
      print(catvoislist.length);
    });
  }

  toCategorize(e) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => categoriesproduct(
                product: widget.product, cUser: crUser, category: e)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            onTap:() => toCategorize(category = "BAKERY"),
            child: Container(
              width: 100,
              child: Card(
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/catimg/bread.png")),
                      Text("BEAKRY"),
                    ]),
              ),
            ),
          ),
          InkWell(
             onTap:() => toCategorize(category = "DAIRY"),
            child: Container(
              width: 100,
              child: Card(
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/catimg/dairy.png")),
                      Text("DAIRY"),
                    ]),
              ),
            ),
          ),
          InkWell(
            onTap:() => toCategorize(category = "BEVERAGES"),
            child: Container(
              width: 100,
              child: Card(
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/catimg/drinks.png")),
                      Text("BEVERAGE"),
                    ]),
              ),
            ),
          ),
          InkWell(
            onTap:() => toCategorize(category = "Frozen Foods"),
            child: Container(
              width: 100,
              child: Card(
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/catimg/frozen.png")),
                      Text("FROZEN"),
                    ]),
              ),
            ),
          ),
          InkWell(
            onTap:() => toCategorize(category = "PRODUCE"),
            child: Container(
              width: 100,
              child: Card(
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/catimg/produce.png")),
                      Text("PRODUCE"),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
