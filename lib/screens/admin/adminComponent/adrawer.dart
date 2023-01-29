import 'package:flutter/material.dart';

import '../../login.dart';
import '../Manageproducts.dart';
import '../Users.dart';
import '../admindash.dart';
import '../Admin_orders.dart';

class AdDrawer extends StatefulWidget {
  const AdDrawer({super.key});

  @override
  State<AdDrawer> createState() => _AdDrawerState();
}

class _AdDrawerState extends State<AdDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
             decoration: const BoxDecoration(
                     image: DecorationImage(
                     image: AssetImage("assets/images/drawerimg.jpg"),
                       fit: BoxFit.cover,
                       colorFilter:  ColorFilter.mode(
    Color.fromARGB(146, 77, 76, 76),
    BlendMode.darken,
  ),
                     )),
            child:Container(
              padding: const EdgeInsets.only(top: 80),
              child: const Text("GROCETERIA",style: TextStyle(fontSize: 45, color: Colors.white),),),
            
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png'),
                                radius: 50,
                              ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:15),
                          child: Column(
                                children: [
                                  Text('Admin',style: const TextStyle(fontSize: 25),),
                                  Text('aliabbas.tech03@gmail.com',style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                        ),
                            
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
             leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Admindash()),
              );
            },
          ),
          ListTile(
             leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Manage Products '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageProducts()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Manage User'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageUsers()),
              );
            },
          ),
          ListTile(
             leading: const Icon(Icons.propane),
            title: const Text('Manage orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersAdmin()),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Lougout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
