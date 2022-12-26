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
  
  dynamic data;
  Future getusers() async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      var resp = jsonDecode(response.body);
      data = resp;
     
    });
    // data.map((e) => print(e[' name'])).toList();
  }

  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Widget listatble() {
    final columns = ["productID","name","category","tags","price","quantity","image1"];
    final List<dynamic> datas = data;
    return DataTable(
        columns: getColumn(columns),
        rows: datas.map((item) {
          return DataRow(
            cells: [
              DataCell(Text(item['productID'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['category'])),
              DataCell(Text(item['price'])),
              DataCell(Text(item['quantity'])),
              DataCell(Text(item['tags'])),
              DataCell(SizedBox(
                  height: 30, width: 30, 
                  child: Image.network(item['image1']))),
            ],
          );
        }).toList());
  }
  List<DataColumn> getColumn(List<dynamic> columns) => columns
      .map((dynamic column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data == null
              ?  Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal, 
                  child: listatble()),
        
      
    );
  }
}































































// ______________**************** old code to collect data 





// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductTable extends StatefulWidget {
//   const ProductTable({super.key});

//   @override
//   State<ProductTable> createState() => _ProductTableState();
// }

// class _ProductTableState extends State<ProductTable> {
//   var url =
//       "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";
//   List keys = [];
//   List values = [];
//   List finallist = [];
//   dynamic data;
//   Future getusers() async {
//     final response = await http.get(Uri.parse(url));

//     setState(() {
//       var resp = jsonDecode(response.body);
//       data = resp;
//       var len = resp[0].keys.length;
//       keys = resp[0].keys.toList();
//       for (var i in resp) {
//         var list = [];
//         for (var j = 0; j < i.length; j++) {
//           list.add(i['${keys[j]}']);
//         }
//         values.add(list);
//       }

//       for (var j = 0; j < values.length; j++) {
//         if (j < keys.length) {
//           var k = [];
//           for (var v in values) {
//             k.add(v[j]);
//           }
//           finallist.add(k);
//         }
//       }
//     });
//     // data.map((e) => print(e[' name'])).toList();
//   }

//   @override
//   void initState() {
//     super.initState();
//     this.getusers();
//   }

//   Widget listatble() {
//     final columns = ["productID","name","category","tags","price","quantity","image1"];
//     print(columns);
//     final List<dynamic> datas = data;
//     return DataTable(
//         columns: getColumn(columns),
//         rows: datas.map((item) {
//           return DataRow(
//             cells: [
//               DataCell(Text(item['productID'])),
//               DataCell(Text(item['name'])),
//               DataCell(Text(item['category'])),
//               DataCell(Text(item['price'])),
//               DataCell(Text(item['quantity'])),
//               DataCell(Text(item['tags'])),
//               DataCell(SizedBox(
//                   height: 30, width: 30, 
//                   child: Image.network(item['image1']))),
//             ],
//           );
//         }).toList());
//   }

//   List<DataColumn> getColumn(List<dynamic> columns) => columns
//       .map((dynamic column) => DataColumn(
//             label: Text(column),
//           ))
//       .toList();

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: data == null
//               ?  Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   scrollDirection: Axis.horizontal, 
//                   child: listatble()),
        
      
//     );
//   }
// }
