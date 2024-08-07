import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String _baseURL = 'http://10.0.2.2:8080/';
List<String> workoutNames = [];
List<bool> checked = [];

class WorkoutAssignmentPage extends StatefulWidget {
  final String ID;

  const WorkoutAssignmentPage({Key? key, required this.ID}) : super(key: key);

  @override
  _WorkoutAssignmentPageState createState() => _WorkoutAssignmentPageState();
}

class _WorkoutAssignmentPageState extends State<WorkoutAssignmentPage> {
  @override
  void initState() {
    super.initState();
    getAssignedExercises(widget.ID);
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assign Workout',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: workoutNames.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              workoutNames[index],
              style: TextStyle(color: Colors.white),
            ),
            value: checked[index],
            onChanged: (bool? value) {
              setState(() {
                checked[index] = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
            checkColor: Colors.white,
            activeColor: Colors.white,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Delete unchecked exercises
          for (int i = 0; i < workoutNames.length; i++) {
            if (!checked[i]) {
              deleteExercises(widget.ID, '${i + 1}');
            }
          }

          // Add checked exercises
          for (int i = 0; i < checked.length; i++) {
            if (checked[i]) {
              addExercises(widget.ID, '${i + 1}');
            }
          }
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.white,
      ),
    );
  }

  void getAssignedExercises(String userID) async {
    try {
      final assignedResponse = await http.post(
        Uri.parse('$_baseURL/php/getAssignedExercises.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID}),
      ).timeout(const Duration(seconds: 5));

      if (assignedResponse.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(assignedResponse.body);

        workoutNames.clear();
        checked.clear();

        for (var row in jsonResponse['exercises']) {
          workoutNames.add(row['exerciseType']);
          checked.add(true);
        }

        final allExercisesResponse = await http.get(
          Uri.parse('$_baseURL/php/getAllExercises.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
        ).timeout(const Duration(seconds: 5));

        if (allExercisesResponse.statusCode == 200) {
          final allExercises = convert.jsonDecode(allExercisesResponse.body);
          for (var row in allExercises) {
            if (!workoutNames.contains(row['exerciseType'])) {
              workoutNames.add(row['exerciseType']);
              checked.add(false);
            }
          }

          setState(() {});
        }
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void addExercises(String userID, String exerciseID) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/addExercises.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID, 'exerciseID': exerciseID}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        print('Exercise added: ${response.body}');
      } else {
        print('Failed to add exercise: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  void deleteExercises(String userID, String exerciseID) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/deleteExercise.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID, 'exerciseID': exerciseID}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        print('Exercise deleted: ${response.body}');
      } else {
        print('Failed to delete exercise: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
