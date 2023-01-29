

import 'package:flutter/material.dart';

import '../screens/login.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(0),
                                child: SizedBox(
                                  height: 200,
                                  child: Image.asset('assets/images/comp-2.gif'))),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("we're evaluating your profile",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Flexible(
                                child: Text(
                                  "in order to make sure our community holds up a standard, we don't allow any profile to get in",
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Flexible(
                                child: Text(
                                  "if you want to Approve Account contact Admin and pay minimum amount of 5000 to activate your account contact:03412771539 ",
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: Image.network("https://easypaisa.com.pk/wp-content/uploads/2021/10/Asset-1@4x-8-300x63.png")),
                                        Text("Easy paisa"),
                                        Text("03412771539"),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: Image.network("https://upload.wikimedia.org/wikipedia/en/thumb/b/b4/JazzCash_logo.png/220px-JazzCash_logo.png")),
                                        Text("Jazz Cash"),
                                      Text("03412771539"),
                                    ],
                                  )
                                ],
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
                  ),
    );
  }
}