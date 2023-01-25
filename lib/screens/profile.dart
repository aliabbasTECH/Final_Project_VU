import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../component/userdrawer.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final Data;

  Profile({this.Data});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic userData;

  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  Future getusers() async {
    final response = await http.get(Uri.parse(
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users/${widget.Data[1]}.json"));
    setState(() {
      dynamic res = jsonDecode(response.body);
      userData = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Data);
    return SafeArea(
      child: Scaffold(
        // drawer: UserDrawer(userdata: widget.Data),
        body: userData == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png'),
                          radius: 50,
                        ),
                      ),
                       Text(
                                    "${userData['firstName']}${userData['lastName']} ",
                                    style: TextStyle(
                                      fontSize: 40,
                                    )),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Text(
                            //     "Current Amount : ${userData['Amount'] == null ? "00000" : userData['Amount'] } ",
                            //     style: TextStyle(fontSize: 18)),

                            SizedBox(
                              height: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                Text(
                                    "${userData['firstName']}${userData['lastName']} ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ],
                            ),
                            Divider(
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                Text("${userData['email']} ",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            Divider(
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "mobile",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                Text("${userData['mobile']}",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            Divider(
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                Text(
                                    "${userData['houseNo']} ${userData['socity']} ${userData['city']}",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),

                            Divider(
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                Text(
                                    "${userData['Amount'] == null ? "00000" : userData['Amount']}",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(80),
                        child: ElevatedButton.icon(
                          
                           icon: Icon(Icons.logout),
                          onPressed:() { 
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()), );
                              }, 
                          label:  const Text("Logout",style: TextStyle(fontSize: 20),)),
                      )
                    ],
                  ),

                  
                ),
              ),
      ),
    );
  }
}
