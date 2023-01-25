import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../component/emptycart.dart';
import 'placeOrder.dart';

class UserOderDAta extends StatefulWidget {
  final uuid;
  UserOderDAta({this.uuid});

  @override
  State<UserOderDAta> createState() => _UserOderDAtaState();
}

class _UserOderDAtaState extends State<UserOderDAta> {
  dynamic url;
  dynamic cartproducts;
  dynamic keysdata;

  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.uuid}/orders.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      if (resp != null) {
        cartproducts = resp;
        keysdata = cartproducts.keys.toList();
        print(cartproducts);
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    this.getusersdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Container(
        child: cartproducts == null
            ?  emptyCart()
            : ListView.builder(
                itemCount: cartproducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(
                      height: 40,
                      width: 30,
                      child: Image.network(
                          "${cartproducts[keysdata[index]]['image']}",
                          fit: BoxFit.cover),
                    ),
                    title: Text(
                      "${cartproducts[keysdata[index]]['productNmae']}",
                      style: TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(
                      "price : ${cartproducts[keysdata[index]]['price']} | Date:${cartproducts[keysdata[index]]['date']}",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: SizedBox(width: 100, child: Text("inprocess")),
                  );
                },
              ),
      ),
    );
  }
}
