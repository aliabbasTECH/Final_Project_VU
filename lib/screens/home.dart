import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../component/productcard.dart';
import '../component/userdrawer.dart';
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
                ? Text("Daily Groceries")
                : Text(" Pending Aproval")),
                drawer: UserDrawer(drEmail:widget.email,drPin:widget.pin,drkey:crUser[1]),
        body: approve.toString() == "true"
            ? ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Color.fromARGB(255, 252, 220, 103),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text("$username",style: TextStyle(fontSize: 19,color: Colors.green),),
                                  Text(widget.email,style: TextStyle(fontSize: 12,color: Colors.green)),
                                ],
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: new BoxDecoration(
                                 color: Colors.green,
                                 borderRadius: new BorderRadius.circular(50),
                                 boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 4,
        offset: Offset(1, 1), // Shadow position
      ),
    ],
                                  ),
                                child: Text('$camount Rs',style: TextStyle(fontSize: 20))
                                )
                            ],
                          ),
                        ),
                      ),
                      ProductCardView(product: pro, cUser: crUser)
                    ],
                  )
                ],
              )
            : Center(child: ApprovelMsg())
            );
  }
}
