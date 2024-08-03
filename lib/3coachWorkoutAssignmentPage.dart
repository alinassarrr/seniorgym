import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://seniorproject30.000webhostapp.com/';
final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();
List<String> workoutNames = [
  'biceps',
  'shoulders',
  'back',
  'legs',
  'tpose',
  'treepose',
  'warriorpose'
];
List<bool> checked = List.filled(workoutNames.length, false);

class WorkoutAssignmentPage extends StatefulWidget {
  final String ID;

  const WorkoutAssignmentPage({Key? key, required this.ID}) : super(key: key);

  @override
  _WorkoutAssignmentPageState createState() => _WorkoutAssignmentPageState();
}

class _WorkoutAssignmentPageState extends State<WorkoutAssignmentPage> {
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    getExercises(refresh, widget.ID);
    super.initState();
  }

  @override
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
          color: Colors.white, // Back button color
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
            // Align checkbox to the right
            checkColor: Colors.white,
            // Color of the checkbox
            activeColor: Colors.white, // Color of the checked checkbox
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteExercises(widget.ID);
          for (int i = 0; i < checked.length; i++) {
            if (checked[i]) {
              addExercises(widget.ID, '${i + 1}');
            }
          }
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.white, // Set FAB background color
      ),
    );
  }
}

void getExercises(Function() refresh, String userID) async {
  try {
    final response = await http
        .post(
          Uri.parse('$_baseURL/getExercises.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: convert.jsonEncode(<String, String>{'id': userID}),
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      print(response.body);
      final jsonResponse = convert.jsonDecode(response.body);
      // Initialize checked list
      for (var row in jsonResponse) {
        for (int i = 0; i < workoutNames.length; i++) {
          if (workoutNames[i] == row['exerciseType']) {
            checked[i] = true;
            break; // No need to continue searching once a match is found
          }
        }
      }
      refresh();
      // Do something with the checked list here
    }
  } catch (e) {
    print('Error occurred: $e hahahhahhaha');
  }
}

void addExercises(String userID, String exerciseID) async {
  try {
    final response = await http
        .post(
          Uri.parse('$_baseURL/addExercises.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: convert.jsonEncode(
              <String, String>{'id': userID, 'exerciseID': exerciseID}),
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      print(response.body);
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

void deleteExercises(String userID) async {
  try {
    final response = await http
        .post(
          Uri.parse('$_baseURL/deleteExercises.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: convert.jsonEncode(<String, String>{'id': userID}),
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      print(response.body);
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
