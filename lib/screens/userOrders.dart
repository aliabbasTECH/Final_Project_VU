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
  dynamic restoreamount;
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

  cancelOrder(u, p, a) async {
    print(u + ":" + p);
    setState(() async {
      final orderresp = await http.delete(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$p.json"));
      final userorderresp = await http.delete(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$u/orders/$p.json"));

      if (orderresp.statusCode == 200 || userorderresp.statusCode == 200) {
        print('Key deleted successfully');

        var Amountupdateurl =
            "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$u.json";
        final response = await http.get(Uri.parse(Amountupdateurl));
        dynamic resp = jsonDecode(response.body);
        int cra = int.parse(resp['Amount']);
        int prd = a as int;

        restoreamount = cra + prd;
        print(restoreamount);
        await http.patch(Uri.parse(Amountupdateurl),
            body: jsonEncode({
              'Amount': restoreamount.toString(),
            }));
        cartproducts = null;
        getusersdata();
      } else {
        print(
            'Error deleting key: ${orderresp.statusCode}:${userorderresp.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Container(
        child: cartproducts == null
            ? const emptyCart()
            : ListView.builder(
                itemCount: cartproducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: Image.network(
                                "${cartproducts[keysdata[index]]['image']}",
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cartproducts[keysdata[index]]['Pname']}",
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                "price : ${cartproducts[keysdata[index]]['price']} | Date:${cartproducts[keysdata[index]]['date']}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 10),
                          child: cartproducts[keysdata[index]]['delivered'] == true
                                      ? Text("Completed",
                                          style: TextStyle(color: Colors.green))
                                      :Column(
                            children: [
                              const Text("inprocess"),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 35,
                                child: ElevatedButton(
                                    onPressed: () => cancelOrder(
                                        cartproducts[keysdata[index]]
                                            ['userUuid'],
                                        keysdata[index],
                                        cartproducts[keysdata[index]]['price']),
                                    child: const Text("cancel")),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
