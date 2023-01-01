import 'dart:convert';
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

  @override
  void initState() {
    super.initState();
    this.getusers();
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
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Products",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.network(
                                  'https://www.tazaonline.com/wp-content/uploads/2022/01/Round-Burger-Bun-2pcs-800x436-removebg-preview.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'BUNNYS BIG ROUND BURGER 2PCS',
                                ),
                              ],
                            ),
                          ),
                          
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.network(
                                  'https://dawnbread.com/wp-content/uploads/2021/05/Plain-Bread-PNG-1.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'dawnbread',
                                ),
                              ],
                            ),
                          ),
                          ProductCardView()
                          
                        ],
                      ),
                    ],
                  )
                ],
              )
            : Center(
                child: ApprovelMsg()
              ));
  }
}
