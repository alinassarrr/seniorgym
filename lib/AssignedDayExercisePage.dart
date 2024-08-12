import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AssignedDayExercisePage extends StatefulWidget {
  final String userID;
  final String dateAssigned;

  AssignedDayExercisePage({required this.userID, required this.dateAssigned});

  @override
  _AssignedDayExercisePageState createState() => _AssignedDayExercisePageState();
}

class _AssignedDayExercisePageState extends State<AssignedDayExercisePage> {
  bool isLoading = true;
  List<Map<String, dynamic>> exercises = [];

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/php/getExercisesAssigned.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{
          'id': widget.userID,
          'dateAssigned': widget.dateAssigned,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = convert.jsonDecode(response.body)['exercises'];
        setState(() {
          exercises = jsonResponse.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        print('Failed to load exercises: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercises for ${widget.dateAssigned}',
          style: TextStyle(color: Colors.white),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : exercises.isEmpty
          ? Center(
        child: Text(
          'No exercises assigned for this date.',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ListTile(
            title: Text(
              exercise['exerciseType'],
              style: TextStyle(color: Colors.white,fontSize: 22),
            ),
            trailing: ElevatedButton(
              onPressed: exercise['isDone'] == 1
                  ? null
                  : () {
                markExerciseAsDone(exercise['exerciseID'].toString(), index);
              },
              child: Text('Done'),
              style: ElevatedButton.styleFrom(
                primary: exercise['isDone'] == 1 ? Colors.white : Colors.green,
                onPrimary: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> markExerciseAsDone(String exerciseID, int index) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/php/markExerciseDone.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{
          'userID': widget.userID,
          'exerciseID': exerciseID,
          'dateAssigned': widget.dateAssigned,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          exercises[index]['isDone'] = 1;
        });
        print('Exercise marked as done.');
      } else {
        print('Failed to mark exercise as done: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}