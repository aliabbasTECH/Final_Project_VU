import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Admin_orders.dart';

import 'adrawer.dart';

class AdminOrderDetailPage extends StatefulWidget {
  final Data;

  AdminOrderDetailPage({this.Data});

  @override
  State<AdminOrderDetailPage> createState() => _AdminOrderDetailPageState();
}

class _AdminOrderDetailPageState extends State<AdminOrderDetailPage> {
  TextEditingController _textFieldController = TextEditingController();
  dynamic orderData;

  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Future getusers() async {
    setState(() {
      orderData = widget.Data;
    });
  }

  // orderComplete(e) async {
  //    print(e);
  //   var appr = await http.get(Uri.parse(
  //       "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$e/delivered.json"));
  //   if(appr.body != true ){
  //     http.patch(
  //           Uri.parse(
  //               "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$e.json"),
  //           body: jsonEncode({
  //             'delivered': true,
  //           }));
  //   }
  // }

  Ordercomplete(e, u) async {
    print("$e:$u");
    var appr = await http.get(Uri.parse(
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$e/delivered.json"));
    if (appr.body != true) {
      http.patch(
          Uri.parse(
              "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$e.json"),
          body: jsonEncode({
            'delivered': true,
          }));
      http
          .patch(
              Uri.parse(
                  "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$u/orders/$e.json"),
              body: jsonEncode({
                'delivered': true,
              }))
          .then(await Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrdersAdmin())));
    }
  }

  deleteOrder(e, u) async {
    setState(() async {
      final orderresp = await http.delete(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders/$e.json"));
      final userorderresp = await http.delete(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$u/orders/$e.json"));

      if (orderresp.statusCode == 200 || userorderresp.statusCode == 200) {
        print('Key deleted successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrdersAdmin()));
      } else {
        print(
            'Error deleting key: ${orderresp.statusCode}:${userorderresp.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Order detail")),
        drawer: AdDrawer(),
        body: orderData == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Image.network("${orderData['pimage']}"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${orderData['Pname']} ",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "OrderDetail",
                              style: TextStyle(fontSize: 17),
                            ),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("privousAmount : ${orderData['Productid']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("price: : ${orderData['price']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text(
                                "privousAmount : ${orderData['privousAmount']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text(
                                "deductedAmount : ${orderData['deductedAmount']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("userName : ${orderData['userName']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Email : ${orderData['email']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("mobile : ${orderData['mobile']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("city : ${orderData['city']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Address : ${orderData['address']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Approve : ${orderData['delivered']}"),
                          ],
                        ),
                      ),

                      // productsbyUser();

                      Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: orderData['delivered'] != false
                                ? Container(
                                    child: Text("Order is Completed"),
                                  )
                                : Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => deleteOrder(
                                              widget.Data['Productuuid'],
                                              widget.Data['userUuid']),
                                          child: Text("CancelOrder")),
                                      Spacer(),
                                      ElevatedButton(
                                          onPressed: () => Ordercomplete(
                                              widget.Data['Productuuid'],
                                              widget.Data['userUuid']),
                                          child: Text("Complete the order")),
                                    ],
                                  )),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
