import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductTable extends StatefulWidget {
  const ProductTable({super.key});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  var url =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";
  List keys = [];
  List values = [];
  List finallist = [];
  dynamic data;
  Future getusers() async {
    final response = await http.get(Uri.parse(url));

    setState(() {
      var resp = jsonDecode(response.body);
      var len = resp[0].keys.length;
      keys = resp[0].keys.toList();
      for (var i in resp) {
        var list = [];
        for (var j = 0; j < i.length; j++) {
          list.add(i['${keys[j]}']);
        }
        values.add(list);
      }

      for (var j = 0; j < values.length; j++) {
        if (j < keys.length) {
          var k = [];
          for (var v in values) {
            k.add(v[j]);
          }
          finallist.add(k);
        }
      }
    });

    print(finallist);
  }

  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text("Datatables"),
          // dataTablebody(),
        ],
      )),
    );
  }
}
