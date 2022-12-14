import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'adminComponent/adrawer.dart';

class Admindash extends StatefulWidget {
  const Admindash({super.key});

  @override
  State<Admindash> createState() => _AdmindashState();
}

class _AdmindashState extends State<Admindash> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dash")),
      drawer:AdDrawer() ,
      body:Column(children: [
        Row(children: [
          Text("Admin Dashboard"),
          Spacer(), ],)

      ],)
    );
  }
}
