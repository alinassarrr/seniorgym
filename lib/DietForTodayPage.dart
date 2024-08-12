import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'AssignedDayDietPage.dart'; // This page will be similar to AssignedDayExercisePage but for diet

class DietForTodayPage extends StatefulWidget {
  final String userID;

  DietForTodayPage({required this.userID});

  @override
  _DietForTodayPageState createState() => _DietForTodayPageState();
}

class _DietForTodayPageState extends State<DietForTodayPage> {
  List<String> assignedDates = [];

  @override
  void initState() {
    super.initState();
    fetchAssignedDates();
  }

  Future<void> fetchAssignedDates() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/php/getAssignedDietDates.php'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: convert.jsonEncode(<String, String>{'userID': widget.userID}),
      );

      if (response.statusCode == 200) {
        setState(() {
          assignedDates = List<String>.from(convert.jsonDecode(response.body));
        });
      } else {
        print('Failed to load dates');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Your Diet Today       ',
            style: TextStyle(color: Colors.white),
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
      body: assignedDates.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: assignedDates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignedDayDietPage( // Create this page similarly to AssignedDayExercisePage
                    userID: widget.userID,
                    dateAssigned: assignedDates[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/weightGainDinner.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  assignedDates[index],
                  style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
