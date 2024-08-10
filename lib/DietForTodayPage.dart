import 'package:flutter/material.dart';

class DietForTodayPage extends StatelessWidget {
  final String userID;

  DietForTodayPage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Your Diet Today',
            style: TextStyle(color: Colors.white),  // Set the text color to white
          ),
        ),        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'This is the Diet for Today page for user $userID',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
