
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'adminComponent/adrawer.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {

  var url =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users.json";

  dynamic data;
  dynamic len;
  dynamic keys;
 

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
      print(data[keys][len]);
    });
  }

  approve(e) async {
    setState(() async {
      var appr = await http.get(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$e/Aproved.json"));
      if (appr != true) {
        http.patch(
            Uri.parse(
                "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$e.json"),
            body: jsonEncode({
              'Aproved': true,
            }));
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Users")),
      drawer:AdDrawer() ,
      body: ListView.builder(
        itemCount: data == null ? 0 : len,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(data[keys[index]]['firstName']+data[keys[index]]['lastName']),
                                  SizedBox(height: 3,),
                                  Text(data[keys[index]]['email']),
                                  
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () => approve(keys[index]),
                                  icon: Icon(Icons.approval,
                                      size: 14.0,
                                      color:  Colors.green
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}