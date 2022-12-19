import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductTable extends StatefulWidget {
  const ProductTable({super.key});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  

  // var url =
  //     "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";
  // var keys = [];
  // dynamic data;
  // Future getusers() async {
  //   final response = await http.get(Uri.parse(url));
  //   setState(() {
  //     List resp = jsonDecode(response.body);
  //     data = resp;
  //     print(data[7].values);
  //     // for (var r in resp) {
  //     //   var len = r.keys.length;
  //     //   var k = r.keys.toList();
  //     //   var d = r.values;
  //     //   // print(d);
  //     // }

  //     // print(keys);
  //     // print("___________________________");
  //     // print(data);
  //     // len = res.keys.length;
  //     // keys = res.keys.toList();
  //     // print(data[keys][len]);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.getusers();
  }

  // Widget dataTablebody() => DataTable(
  //     columns: data.map((e) => DataRow(
  //       cells: [DataCell(Text(e.keys))]
  //       )),
  //     rows: data.map((e) => DataRow(
  //       cells: [DataCell(Text(e.valus))]
  //       )));

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
