import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Users.dart';
import 'adminComponent/adrawer.dart';

class Userdetails extends StatefulWidget {
  final Data;

  Userdetails({this.Data});

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  TextEditingController _textFieldController = TextEditingController();
  dynamic userData;
  dynamic amount;
  dynamic valueText;
  dynamic usercarts;
  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Future getusers() async {
    final response = await http.get(Uri.parse(
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.Data['uuid']}.json"));
    setState(() {
      dynamic res = jsonDecode(response.body);
      amount = res['Amount'];
      userData = res;
      usercarts = res['data'];
      print(usercarts);
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageUsers()));
      }
    });
  }

  disapprove(e) async {
    setState(() async {
      var appr = await http.get(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$e/Aproved.json"));
      if (appr != false) {
        http.patch(
            Uri.parse(
                "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$e.json"),
            body: jsonEncode({
              'Aproved': false,
            }));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageUsers()));
      }
    });
  }

  deleteUser(e) async {
    setState(() async {
      final resp = await http.delete(Uri.parse(
          "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/$e.json"));

      if (resp.statusCode == 200) {
        print('Key deleted successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageUsers()));
      } else {
        print('Error deleting key: ${resp.statusCode}');
      }
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (v) {
                setState(() {
                  valueText = v;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() async {
                    var url =
                        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.Data['uuid']}.json";
                    http.patch(Uri.parse(url),
                        body: jsonEncode({
                          'Amount': valueText,
                        }));
                    await getusers();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("User detail")),
        drawer: AdDrawer(),
        body: userData == null
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
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png'),
                              radius: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${userData['firstName']}${userData['lastName']} ",
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
                            Column(
                              children: [
                                Text(
                                    "Current Amount : ${amount == null ? "00000" : amount} ",
                                    style: TextStyle(fontSize: 18)),
                                Row(
                                  children: [
                                    Spacer(),
                                    ElevatedButton(
                                        onPressed: () =>
                                            _displayTextInputDialog(context),
                                        child: Text("add")),
                                  ],
                                )
                              ],
                            ),
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
                            Text("Email : ${userData['email']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("mobile : ${userData['mobile']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("city : ${userData['city']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text(
                                "Address : ${userData['houseNo']} ${userData['socity']} ${userData['city']}"),
                            Divider(
                              color: Colors.green,
                            ),
                            Text("Approve : ${userData['Aproved']}"),
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
                                    onPressed: () =>
                                        deleteUser(widget.Data['uuid']),
                                    child: Text("Delete")),
                                Spacer(),
                                userData['Aproved'] == false
                                    ? ElevatedButton(
                                        onPressed: () =>
                                            approve(widget.Data['uuid']),
                                        child: Text("Approve"))
                                    : ElevatedButton(
                                        onPressed: () =>
                                            disapprove(widget.Data['uuid']),
                                        child: Text("refused")),
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
