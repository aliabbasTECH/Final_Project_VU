import 'package:daily_groceries/screens/profile.dart';
import 'package:flutter/material.dart';

import '../screens/cartPage.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/userOrders.dart';

class UserDrawer extends StatefulWidget {
  final drEmail;
  final drPin;
  final drkey;
  UserDrawer({
    this.drEmail,
     this.drPin,
     this.drkey
    });

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    print(widget.drEmail);
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
                MaterialPageRoute(
                    builder: (context) => HomePage(email: widget.drEmail,pin: widget.drPin,)),
              );
            },
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(data: {"uuid":widget.drkey},)),
              );
            },
          ),
          ListTile(
            title: const Text('products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserOderDAta(uuid:widget.drkey ,)),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
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
