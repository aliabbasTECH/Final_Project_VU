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
  dynamic userdata;
  dynamic url;
  dynamic cartproducts;
  dynamic keysdata;
  dynamic orderdata;
  DateTime today = DateTime.now();
  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}/savecartitem.json";
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
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}/savecartitem/$e.json";
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

  NavToPlaceorder(e) async {
    var url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.data['uuid']}.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      userdata = resp;
      int cra = int.parse(userdata['Amount']);
      int pr = e['price'] as int;

      // print(pr);
      if (pr <= cra && userdata['Amount'] != null && cra != 0) {
        print("pament suc");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceOrder(orderData: e)));
      } else if (cra == null || pr > cra) {
        _LowAmountDialog(context);
      }
    });
  }

  Future<void> _LowAmountDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Low amount'),
            content: Text(
                'your amount is low plese contact Admin to fill up your amount admin contact = 03412771439  '),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    this.getusersdata();
  }

  @override
  Widget build(BuildContext context) {
    print(cartproducts);
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
                    "${cartproducts[keysdata[index]]['Pname']}",
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    "price : ${cartproducts[keysdata[index]]['price']} | Date:${cartproducts[keysdata[index]]['date']}",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: SizedBox(
                    width: 54,
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
                            onPressed: () => NavToPlaceorder(orderdata = {
                              "date":
                                  '${today.day}-${today.month}-${today.year}',
                              "email": cartproducts[keysdata[index]]['email'],
                              "uuid": cartproducts[keysdata[index]]['uuid'],
                              "uname": cartproducts[keysdata[index]]['uname'],
                              "Pname": cartproducts[keysdata[index]]['Pname'],
                              "price": cartproducts[keysdata[index]]['price'],
                              "productId": cartproducts[keysdata[index]]
                                  ["productId"],
                              "quantity": cartproducts[keysdata[index]]
                                  ['quantity'],
                              "image": cartproducts[keysdata[index]]['image']
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
