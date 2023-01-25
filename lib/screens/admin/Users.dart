import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'UserDetails.dart';
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
    });
  }

  

  UserdetailPage(e) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Userdetails(Data: e)));
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("Manage Users")),
      drawer: AdDrawer(),
      body: ListView.builder(
        itemCount: data == null ? 0 : len,
        itemBuilder: (BuildContext context, int index) {
          return keys[index] != "-administratorabc123"
              ? InkWell(
                  onTap: () => UserdetailPage(
                    userDatailData = {
                     "Aproved" :data[keys[index]]["Aproved"],
                     "city" :data[keys[index]]["city"],
                     "date" :data[keys[index]]["date"],
                     "email" :data[keys[index]]["email"],
                     "firstName" :data[keys[index]]["firstName"],
                     "lastName" :data[keys[index]]["lastName"],
                     "houseNo" :data[keys[index]]["houseNo"],
                     "mobile" :data[keys[index]]["mobile"],
                     "socity" :data[keys[index]]["socity"],
                     "uuid" :keys[index],
                     "Amount" :data[keys[index]]['Amount'],
                    }
                    ),
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
                                            "${data[keys[index]]['firstName']}${data[keys[index]]['lastName']}"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(data[keys[index]]['email']),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: data[keys[index]]['Aproved']== true ? Text("approved",style: TextStyle(color: Colors.green))
                                      :Text("refused",style: TextStyle(color: Colors.red))
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
