import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'UserDetails.dart';
import 'adminComponent/adminOrderdetail.dart';
import 'adminComponent/adrawer.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({super.key});

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  var url =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders.json";

  dynamic data;
  dynamic len;
  dynamic keys;
  dynamic userDatailData;
  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Future getusers() async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      Map<String, dynamic> res = jsonDecode(response.body);
      data = res;
      len = res.keys.length;
      keys = res.keys.toList();
      print(data);
    });
  }

  UserdetailPage(e) {
    print(e);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AdminOrderDetailPage(Data: e)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage orders")),
      drawer: AdDrawer(),
      body: ListView.builder(
        itemCount: data == null ? 0 : len,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => UserdetailPage(userDatailData = {
              "Productid": data[keys[index]]["Productid"],
              "address": data[keys[index]]["address"],
              "privousAmount": data[keys[index]]["privousAmount"],
              "deductedAmount": data[keys[index]]["deductedAmount"],
              "date": data[keys[index]]["date"],
              "Pname": data[keys[index]]["Pname"],
              "email": data[keys[index]]["email"],
              "mobile": data[keys[index]]["mobile"],
              "price": data[keys[index]]["price"],
              "userName": data[keys[index]]["userName"],
              "userUuid": data[keys[index]]["userUuid"],
              "Productuuid": keys[index],
              "delivered": data[keys[index]]['delivered'] as bool,
              "pimage": data[keys[index]]['image'],
            }),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${data[keys[index]]['Pname']}"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(data[keys[index]]['email']),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: data[keys[index]]['delivered'] == true
                                      ? Text("OrderCompleted",
                                          style: TextStyle(color: Colors.green))
                                      : Text("inprocess",
                                          style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
