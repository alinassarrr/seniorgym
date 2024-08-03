import 'package:flutter/material.dart';
import 'package:seniorproject/userRolePage.dart';
import 'trainee.dart';
import '1coach.dart';
import 'AdminLoginPage.dart';
import 'NormalLoginPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NormalLoginPage(),
      debugShowCheckedModeBanner: false,
      title: "project",
    );


//bold w akbar w kellon caps on
// watte contrast lal images aashen ktir mdawin
 //new acc aa webhost w new database aa webhost
  }
}




