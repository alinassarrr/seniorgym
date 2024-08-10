import 'package:flutter/material.dart';

class ActivityLogPage extends StatelessWidget {
  final String userID;

  ActivityLogPage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Activity Log',
            style: TextStyle(color: Colors.white),  // Set the text color to white
          ),
        ),
        backgroundColor: Colors.black,
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
          'This is the Activity Log page for user $userID',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
