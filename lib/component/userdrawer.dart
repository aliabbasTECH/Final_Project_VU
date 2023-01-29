import 'package:daily_groceries/screens/profile.dart';
import 'package:flutter/material.dart';

import '../screens/cartPage.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/userOrders.dart';

class UserDrawer extends StatefulWidget {
  final userdata;

  UserDrawer({
    this.userdata,
  });

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    print(widget.userdata);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
             decoration: const BoxDecoration(
                     image: DecorationImage(
                     image: AssetImage("assets/images/drawerimg.jpg"),
                       fit: BoxFit.cover,
                       colorFilter:  const ColorFilter.mode(
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
                                  Text('${widget.userdata[2]}',style: const TextStyle(fontSize: 25),),
                                  Text('${widget.userdata[0]}',style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                        ),
                            Container(
                              decoration: BoxDecoration(
             gradient:const LinearGradient(
                  colors: [
                    Colors.greenAccent, 
                    Colors.green,
                    Colors.teal,
                    Colors.tealAccent
                    //add more colors for gradient
                   ],
                  begin: Alignment.topLeft, //begin of the gradient color
                  end: Alignment.bottomRight, //end of the gradient color
                  stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                  //set the stops number equal to numbers of color
             ),

             borderRadius: BorderRadius.circular(30), //border corner radius
             
          ),
                             
                              padding: const EdgeInsets.all(15),
                              child: Text( '${widget.userdata[3] ?? "00000"} Rs' ,style: TextStyle(fontSize:18),),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
        
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          email: widget.userdata[0],
                        )),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(
                          data: {"uuid": widget.userdata[1]},
                        )),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserOderDAta(
                          uuid: widget.userdata[1],
                        )),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Profile(Data:widget.userdata)),
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
