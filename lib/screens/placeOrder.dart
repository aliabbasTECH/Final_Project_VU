import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'home.dart';

class PlaceOrder extends StatefulWidget {
  final orderData;
  PlaceOrder({this.orderData});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  dynamic url;
  dynamic cartproducts;
  dynamic keysdata;
  dynamic productinfo;
  int detectedAmount = 0;

  Future getusersdata() async {
    url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.orderData['uuid']}.json";
    final response = await http.get(Uri.parse(url));

    setState(() {
      dynamic resp = jsonDecode(response.body);
      if (resp != null) {
        cartproducts = resp;
        productinfo = widget.orderData;
        int cra = int.parse(cartproducts['Amount']);
        int prd = productinfo['price'] as int;
          detectedAmount = cra - prd;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getusersdata();
  }

  buyFunction() async {
        
    var orderurl =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/orders.json";

      var res = await http.post(Uri.parse(orderurl),
        body: json.encode({
          'userName': cartproducts['name'],
          'email': cartproducts['email'],
          'Productid': productinfo['productId'],
          'productNmae': widget.orderData['name'],
          'mobile': cartproducts['mobile'],
          'address': cartproducts['mobile'],
          'quantity':'${cartproducts['houseNo']} ${cartproducts['socity']} ${cartproducts['city']}',
          'price': productinfo['price'],
          'currentAmount': cartproducts['mobile'],
          'deducted Amount': detectedAmount ,
          'date' : productinfo['date'],
          'image':widget.orderData['image']
        }));
       
      var userurl =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.orderData['uuid']}/orders.json";
      var respuser = await http.post(Uri.parse(userurl),
        body: json.encode({
          'userName': cartproducts['name'],
          'email': cartproducts['email'],
          'Productid': productinfo['productId'],
          'productNmae': widget.orderData['name'],
          'mobile': cartproducts['mobile'],
          'address': cartproducts['mobile'],
          'quantity':'${cartproducts['houseNo']} ${cartproducts['socity']} ${cartproducts['city']}',
          'price': productinfo['price'],
          'currentAmount': cartproducts['mobile'],
          'deducted Amount': detectedAmount ,
          'date' : productinfo['date'],
          'image':widget.orderData['image']
        }));
        var Amountupdateurl =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.orderData['uuid']}.json";
          http.patch(Uri.parse(Amountupdateurl),
                    body: jsonEncode({
                      'Amount': detectedAmount.toString(),
                    }))
     .then(
     await Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(email:cartproducts['email'],pin:cartproducts['pin']),),)
     );
  }

  @override
  Widget build(BuildContext context) {
    print(" thisis =================> $detectedAmount");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("User detail")),
        body: cartproducts == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(widget.orderData['image']),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.orderData['name']} ",
                              style: TextStyle(fontSize: 18),
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
                            Text(
                              "UserDetails",
                              style: TextStyle(fontSize: 18),
                            ),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Email : ${cartproducts['email']} "),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("mobile : ${cartproducts['mobile']} "),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("city : ${cartproducts['city']} "),
                            Divider(
                              color: Colors.green,
                            ),
                            Text(
                                "Address : ${cartproducts['houseNo']} ${cartproducts['socity']} ${cartproducts['city']} "),
                            Divider(
                              color: Colors.green,
                            ),
                            Text(
                                "CurrentAmount : ${cartproducts['Amount']}Rs "),
                            Divider(
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Product Detail",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                             Text("Date : ${productinfo['date']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("product : ${productinfo['productId']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Quantity : ${productinfo['quantity']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("price :  ${productinfo['price']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("deducted Amount : $detectedAmount"),
                          ],
                        ),
                      ),

                      // productsbyUser();

                      Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text("cancel")),
                                Spacer(),
                                ElevatedButton(
                                    onPressed: buyFunction, child: Text("Buy")),
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
