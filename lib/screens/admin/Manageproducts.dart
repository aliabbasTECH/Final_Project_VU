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
        print(result);

      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Products")),
      drawer: AdDrawer(),
      body: Container(
        child: Column(children: [
          Container(
            child: Row(
              children: [
                Text("Products"),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: selectCSVFile,
                  icon: Icon(Icons.save), //icon data for elevated button
                  label: Text("Upload CSV"), //label text
                )
              ],
            ),
          ),
          ProductTable()
        ]),
      ),
    );
  }
}






//   // for (var h in headers) {
        //   final ln= values[0];
        //   // obj[h] = values.map((e) => e.trim());
        //    print(ln);
        // }

        // for (var i = 0; i < array.length - 1; i++) {
        //   var obj = {};
        //   var li = 1 + i;
        //   var list = array[li].split(',');
        //   for (var j = 0; j < headers.length; j++) {
        //     if (list[j].contains(",")) {
        //       obj[headers[j]] = list[j].split(",").map((e) => e.trim());
        //     } else
        //       obj[headers[j]] = list[j];
        //   }
        //   finalresult.add(obj);
        // print(finalresult);
        // }