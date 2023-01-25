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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 76, 175, 80),
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Admindash()),
              );
            },
          ),
          ListTile(
            title: const Text('Manage Products '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageProducts()),
              );
            },
          ),
          ListTile(
            title: const Text('Manage User'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageUsers()),
              );
            },
          ),
          ListTile(
            title: const Text('Manage orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersAdmin()),
              );
            },
          ),
          
          ListTile(
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
