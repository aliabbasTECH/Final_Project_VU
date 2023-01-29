import 'dart:convert';
import 'package:daily_groceries/screens/admin/admindash.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../component/waitforApprove.dart';
import 'home.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pin = TextEditingController();

  dynamic data;
  dynamic len;
  dynamic keys;
  dynamic admin;

  login() async {
    var url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users.json";
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> res = jsonDecode(response.body);
    data = res;
    len = res.keys.length;
    keys = res.keys.toList();
    admin = data["-administratorabc123"];
    if (_email.text == admin["email"] && _pin.text == admin["pin"].toString()) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Admindash(),
        ),
      );
    }
    res.forEach((key, value) async {
      if (_email.text == value["email"] &&
          _pin.text == value["pin"].toString() &&
          value['Aproved'] == true) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(email: value["email"]),
          ),
        );
      } else if (_email.text == value["email"] &&
          _pin.text == value["pin"].toString() &&
          value['Aproved'] == false) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApprovelMsg(),
          ),
        );
      } else {
        Dialog(
            child: Center(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Account is not approved Wating For Approve"),
                  ),
                ],
              )),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
        ),
        actions: [],
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _email,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    suffixIcon: Icon(
                      Icons.account_circle,
                      color: Color(0xFF757575),
                      size: 22,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _pin,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'pin',
                    hintText: 'Enter pin',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    suffixIcon: Icon(
                      Icons.account_circle,
                      color: Color(0xFF757575),
                      size: 22,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: login,
                        child: Text("Login", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        child: Text("Register", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
