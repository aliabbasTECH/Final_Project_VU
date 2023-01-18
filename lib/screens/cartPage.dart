import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../component/emptycart.dart';
import 'placeOrder.dart';

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
  dynamic orderdata;
   DateTime today = DateTime.now();
  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}/data.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      if (resp != null) {
        cartproducts = resp;
        keysdata = cartproducts.keys.toList();
      } else {}
    });
    // data.map((e) => print(e[' name'])).toList();
  }

  removecartobj(e) async {
    dynamic urltodelet =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}/data/$e.json";
    setState(() async {
      final resp = await http.delete(Uri.parse(urltodelet));

      if (resp.statusCode == 200) {
        print('Key deleted successfully');
        getusersdata();
        cartproducts = null;
      } else {
        print('Error deleting key: ${resp.statusCode}');
      }
    });
  }

  Placeoder(e){
     print(e);
    Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOrder(orderData: e)));
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
        title: Text("Cart"),
      ),
      body: cartproducts == null
          ? const emptyCart()
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
                    "${cartproducts[keysdata[index]]['name']}",
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    "price : ${cartproducts[keysdata[index]]['price']} | Date:${cartproducts[keysdata[index]]['date']}",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: SizedBox(
                    width: 45,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.receipt_long,
                              size: 25,
                              color: Colors.green,
                            ),
                            onPressed: () => Placeoder(orderdata={
                            "date": '${today.day}-${today.month}-${today.year}',
                            "email": cartproducts[keysdata[index]]['email'],
                            "uuid": cartproducts[keysdata[index]]['uuid'],
                            "name": cartproducts[keysdata[index]]['name'],
                            "price": cartproducts[keysdata[index]]['price'],
                            "productId": cartproducts[keysdata[index]]["productID"],
                            "quantity": cartproducts[keysdata[index]]['quantity'],
                            "image":cartproducts[keysdata[index]]['image']
                          }),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => removecartobj(keysdata[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
