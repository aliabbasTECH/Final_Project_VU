import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _fname = TextEditingController();
  TextEditingController _Lname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pin = TextEditingController();
  TextEditingController _houseNo = TextEditingController();
  TextEditingController _socity = TextEditingController();
  TextEditingController _city = TextEditingController();

  DateTime date = DateTime.now();

  Register() async {
    var url =
        "https://daily-groceries-db-default-rtdb.firebaseio.com/database/users.json";
    var res = await http
        .post(Uri.parse(url),
            body: json.encode({
              'firstName': _fname.text,
              'lastName': _Lname.text,
              'email': _email.text,
              'mobile': _mobile.text,
              'pin': _pin.text,
              'houseNo': _houseNo.text,
              'socity': _socity.text,
              'city': _city.text,
              'Aproved': false,
              'date': date.toString(),
            }))
        .then(
         await Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(email:_email.text),),)
        );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Register',
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _fname,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter First name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _Lname,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter Last name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _email,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'email',
                    hintText: 'Enter your email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _mobile,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'phone number',
                    hintText: 'Enter phone Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.number,
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _houseNo,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'house Number',
                    hintText: 'Enter house number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _socity,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Socity ',
                    hintText: 'Enter socity',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: _city,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'city Name',
                    hintText: 'Enter city name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),

              Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
                 padding: EdgeInsets.all(2),
                child: SizedBox(
                   width: 150,
                   height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45), // NEW
                    ),
                    onPressed: Register,
                    child: Text("Register",style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              Padding(
                     padding: EdgeInsets.all(2),
                    child: SizedBox(
                       width: 150,
                   height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           minimumSize: const Size.fromHeight(50), // NEW
                           ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }, child: Text("Login" ,style: TextStyle(fontSize: 18)),                  
                        ),
                    ),
                    ),
              ],),
             
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
