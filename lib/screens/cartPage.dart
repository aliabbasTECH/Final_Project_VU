import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final data;
  CartPage({this.data});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  dynamic url;
  dynamic cartproducts;
  dynamic keysdata;
  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}/data.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      cartproducts = resp;
      keysdata = cartproducts.keys.toList();
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
    // print(keys);
    print(keysdata);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cartproducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 40,
              child: Image.network(
                        "${cartproducts[keysdata[index]]['image']}",
                         fit: BoxFit.cover),
            ),
            title: Text("${cartproducts[keysdata[index]]['name']}"),
            subtitle: Text("price : "),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                setState(() {
                  // _items.removeAt(index);
                });
              },
            ),
          );
        },
      ),
     
    );
  }
}
