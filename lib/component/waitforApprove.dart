

import 'package:flutter/material.dart';

import '../screens/login.dart';

class ApprovelMsg extends StatelessWidget {
  const ApprovelMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(0),
                              child: Image.asset('assets/images/comp-2.gif')),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("we're evaluating your profile",
                                style: TextStyle(fontSize: 20)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Flexible(
                              child: Text(
                                "in order to make sure our community holds up a standard, we don't allow any profile to get in ",
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text("login",
                                    style: TextStyle(fontSize: 18))),
                          )
                        ],
                      )),
                );
  }
}