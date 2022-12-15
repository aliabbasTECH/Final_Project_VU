// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../screens/admin/adminComponent/adrawer.dart';

// class CsvToJson extends StatefulWidget {
//   const CsvToJson({super.key});

//   @override
//   State<CsvToJson> createState() => _CsvToJsonState();
// }

// class _CsvToJsonState extends State<CsvToJson> {
//   File? csvfile;
//   dynamic users;

//   selectCSVFile() async {
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
  
//         print("___________________________");
//         print(dataBuffer);
//         print("___________________________");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Manage Products")),
//       drawer: AdDrawer(),
//       body: Center(
//           child: Column(
//         children: [
//           ElevatedButton(onPressed: selectCSVFile, child: Text("CSV"))
//         ],
//       )),
//     );
//   }
// }

// // class to create list

// class User {
//   String username;
//   String email;
//   String phone;

//   User(this.username, this.email, this.phone);
//   toJson() {
//           return '{ "username": "${username}", "email": "${email}", "phone": "${phone}" }';
//         }
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
