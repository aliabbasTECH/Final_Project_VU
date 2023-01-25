import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../component/categories.dart';
import '../component/productcard.dart';
import '../component/slider.dart';
import '../component/userdrawer.dart';
import '../component/waitforApprove.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  final email;
  

  const HomePage({
    @required this.email,
    
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic crUser;
  dynamic approve;
  dynamic username;
  dynamic camount;
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
          username = "${value["firstName"]} ${value["lastName"]}";
          camount =  value["Amount"] ?? "00000";
          crUser = [
            value["email"],
            key,
            username,
          ];
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
            centerTitle: true,
            title: approve.toString() == "true"
                ? Text("GROCETERIA")
                : Text(" Pending Aproval")),
                drawer: UserDrawer(userdata:crUser),
        body:  approve.toString() == "true"
            ? camount == null? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
              child: Column(
                children: [            
                  ImageSliderDemo(),
                 CategoriesList(),
                pro == null? Center(child: CircularProgressIndicator()) : ProductCardView(product: pro, cUser: crUser)
                ],
              ),
            )
            : Center(child: ApprovelMsg())
            );
  }
}
