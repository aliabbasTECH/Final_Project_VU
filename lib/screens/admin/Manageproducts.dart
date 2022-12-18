import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'adminComponent/adrawer.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  File? csvfile;
  dynamic users;
  // List finalresult = [];
  selectCSVFile() async {
    final csvfileresult = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
   
    if (csvfileresult != null) {
      final path = csvfileresult.files.single.path!;
      setState(() {
        csvfile = File(path);
        users = csvfile?.readAsStringSync();
       print(users);
      var array= users.split("\n");
      
      var result = [];
      var headers = array[0].split(",");
      for (var i = 0; i < array.length - 1 ; i++) { 
           var obj = {};
           var li=1+i;
           var list = array[li].split(',');
           for (var j = 0; j < headers.length ; j++){
               if (list[j].contains(", ")) {
                   obj[headers[j]] = list[j]
                  .split(", ").map((e) =>  e.trim());
          
                  }
               else obj[headers[j]] = list[j];
              }
        result.add(obj); 
       }
     print(result);
      //   var array = csv;
      // // print(array);
      //   var headers = array[0].split(',');
        
        
      //   for (var i = 0; i < array.length - 1; i++) {
      //     var obj = {};
      //     var li = 1 + i;
      //     var list = array[li].split(',');
      //     for (var j = 0; j < headers.length; j++) {
      //       if (list[j].contains(",")) {
      //         obj[headers[j]] = list[j].split(",").map((e) => e.trim());
      //       } else
      //         obj[headers[j]] = list[j];
      //     }
      //     finalresult.add(obj);
      //   }
        
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
        ]),
      ),
    );
  }
}






//  selectCSVFile() async {
//     final result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

//     if (result != null) {
//       final path = result.files.single.path!;
//       setState(() {
//         csvfile = File(path);
//         users = csvfile?.readAsStringSync();
//         List<User> users1 = csvToUsersList(users);

//         String dataBuffer = "";

//         for (var i = 0; i < users1.length; i++) {
//           dataBuffer += (i == 0) ? "" : ",\n";
//           dataBuffer += users1[i].toJson();
//         }
//         dataBuffer = "[" + dataBuffer + "]";

//         print(dataBuffer);
//       });
//     }
//   }



// class User {
//   String username;
//   String email;
//   String phone;

//   User(this.username, this.email, this.phone);
//   toJson() {
//     return '{ "username": "${username}", "email": "${email}", "phone": "${phone}" }';
//   }
// }

// List<User> csvToUsersList(String data) {
//   List<User> users = [];

//   List<String> userin = data.split("\n");

//   for (int i = 1; i < userin.length; i++) {
//     List<String> user = userin[i].split(",");

//     users.add(User(user[0], user[1], user[2]));
//   }

//   return users;
// }




