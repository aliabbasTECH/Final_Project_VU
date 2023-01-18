

import 'package:flutter/material.dart';

class emptyCart extends StatelessWidget {
  const emptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        child: Column(children: [

           Image.asset('assets/images/emptyCart.png')

        ],)
    
    );
  }
}