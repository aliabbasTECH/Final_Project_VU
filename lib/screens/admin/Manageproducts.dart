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

  selectCSVFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

    if (result != null) {
      final path = result.files.single.path!;
      setState(() {
        csvfile = File(path);
        users = csvfile?.readAsStringSync();
        List<User> users1 = csvToUsersList(users);

        String dataBuffer = "";

        for (var i = 0; i < users1.length; i++) {
          dataBuffer += (i == 0) ? "" : ",\n";
          dataBuffer += users1[i].toJson();
        }
        dataBuffer = "[" + dataBuffer + "]";

        print(dataBuffer);
    
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
                  onPressed:selectCSVFile,
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

class User {
  String username;
  String email;
  String phone;

  User(this.username, this.email, this.phone);
  toJson() {
    return '{ "username": "${username}", "email": "${email}", "phone": "${phone}" }';
  }
}

List<User> csvToUsersList(String data) {
  List<User> users = [];

  List<String> userin = data.split("\n");

  for (int i = 1; i < userin.length; i++) {
    List<String> user = userin[i].split(",");

    users.add(User(user[0], user[1], user[2]));
  }

  return users;
}






// Future<void> _dialogBuilder(BuildContext context) {
  
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Note:'),
//           content: const Text(' if you upload new csv file  it will remove privous data.'),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Enable'),
//               onPressed: () {
                
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

