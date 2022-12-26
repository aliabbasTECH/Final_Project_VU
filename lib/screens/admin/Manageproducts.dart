import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'adminComponent/adrawer.dart';
import 'package:http/http.dart' as http;

import 'adminComponent/productTable.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  File? csvfile;
  dynamic users;
  dynamic data;
  var url =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";
  selectCSVFile() async {
    final csvfileresult = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

    if (csvfileresult != null) {
      final path = csvfileresult.files.single.path!;
      setState(() {
        csvfile = File(path);
        users = csvfile?.readAsLinesSync();
        var array = users;
        var head = users.removeAt(0);
        var headers = head.split(',');
        var values;
        var result = [];
        for (var line in array) {
          var obj = {};
          values = line.split(",");
          for (var j = 0; j < headers.length; j++) {
            if (values[j].contains(",")) {
              obj[headers[j]] = values[j].split(",").map((e) => e.trim());
            } else
              obj[headers[j]] = values[j];
          }
          result.add(obj);
        }
        final res = http.put(Uri.parse(url), body: json.encode(result));
        getusers();
      });
    }
  }
// get data in table form

  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Future getusers() async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      var resp = jsonDecode(response.body);
      data = resp;
    });
    // data.map((e) => print(e[' name'])).toList();
  }

  Widget listatble() {
    final columns = [
      "productID",
      "name",
      "category",
      "tags",
      "price",
      "quantity",
      "image1"
    ];
    final List<dynamic> datas = data;
    return DataTable(
        columns: getColumn(columns),
        rows: datas.map((item) {
          print(item);
          return DataRow(
            cells: [
              DataCell(Text(item['productID'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['category'])),
              DataCell(Text(item['price'])),
              DataCell(Text(item['quantity'])),
              DataCell(Text(item['tags'])),
              DataCell(SizedBox(
                  height: 30, width: 30, child: Image.network(item['image1']))),
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
    return Scaffold(
        appBar: AppBar(title: Text("Manage Products")),
        drawer: AdDrawer(),
        body: ListView(children: [
          Container(
            child: Row(
              children: [
                Text("Upload CSV(comma,delimited) "),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: selectCSVFile,
                  icon: Icon(Icons.save), //icon data for elevated button
                  label: Text("Upload CSV"), //label text
                )
              ],
            ),
          ),
          Container(
            child: data == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: listatble()),
          )
        ]));
  }
}
