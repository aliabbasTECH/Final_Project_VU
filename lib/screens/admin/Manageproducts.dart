import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../component/csvConverter.dart';
import 'adminComponent/adrawer.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Products")),
       drawer:AdDrawer() ,
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(children: [
                Text("Products"),
                Spacer(),
                ElevatedButton.icon(
      onPressed: (){
        print("You pressed Icon Elevated Button");
         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CsvToJson()),
              );
      }, 
      icon: Icon(Icons.save),  //icon data for elevated button
      label: Text("Upload CSV"), //label text 
    )
                
                ],),
            ),
    
    
        ]),
      ),
    );
  }
}