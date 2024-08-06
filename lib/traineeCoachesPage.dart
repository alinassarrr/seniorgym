import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080/';
final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

List<Map<String, String>> coaches = []; // Store coach ID and Name

class CoachesPage extends StatefulWidget {
  @override
  _CoachesPageState createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  String selectedCoachID = ''; // Store selected coach ID
  String assignedCoachName = ''; // Store the name of the assigned coach

  @override
  void initState() {
    super.initState();
    getCoach();
    getAssignedCoach(); // Fetch the assigned coach on initialization
  }

  void getCoach() async {
    try {
      final response = await http
          .post(Uri.parse('$_baseURL/php/getCoaches.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          })
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        setState(() {
          coaches.clear();
          for (var row in jsonResponse) {
            coaches.add({
              'id': row['userID'], // Ensure this matches your server's response
              'name': "${row['Fname']} ${row['Lname']}",
            });
          }
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> getAssignedCoach() async {
    try {
      final traineeID = await _encryptedData.getString('traineeID'); // Get the trainee ID from encrypted shared preferences

      final response = await http.post(
        Uri.parse('$_baseURL/php/getAssignedCoach.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'userID': traineeID,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);

        setState(() {
          selectedCoachID = jsonResponse['coachID']?.toString() ?? ''; // Convert to string if necessary
          if (selectedCoachID.isNotEmpty) {
            final selectedCoach = coaches.firstWhere(
                  (coach) => coach['id'] == selectedCoachID,
              orElse: () => {'name': 'Unknown'},
            );
            assignedCoachName = selectedCoach['name'] ?? 'Unknown';
          } else {
            assignedCoachName = 'No coach assigned';
          }
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void showSelectedCoach() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Coach'),
          content: Text('Do you want to change to $assignedCoachName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the alert dialog
                Navigator.of(context).pop(); // Navigate back to the previous screen
                await assignCoach(); // Assign or update the coach
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog without action
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }


  Future<void> assignCoach() async {
    try {
      final traineeID = await _encryptedData.getString('traineeID'); // Get the trainee ID from encrypted shared preferences
      final now = DateTime.now().toIso8601String(); // Current timestamp for date

      // Check if a coach is already assigned
      final checkResponse = await http.post(
        Uri.parse('$_baseURL/php/check_coach.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'userID': traineeID,
        }),
      );

      if (checkResponse.statusCode == 200) {
        final checkJsonResponse = convert.jsonDecode(checkResponse.body);
        final existingCoachID = checkJsonResponse['coachID'];

        // Decide whether to update or insert based on existing assignment
        final updateResponse = await http.post(
          Uri.parse('$_baseURL/php/updateCoach.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(<String, String>{
            'userID': traineeID,
            'coachID': selectedCoachID,
            'date': now,
          }),
        );

        if (updateResponse.statusCode == 200) {
          // Handle successful response
          print('Coach updated successfully');
        } else {
          // Handle error response
          print('Error: ${updateResponse.statusCode}');
        }
      } else {
        print('Error checking coach assignment: ${checkResponse.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coaches',
          style: TextStyle(color: Colors.white), // Set title text color to white
        ),
        centerTitle: true, // Center align the title
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Set the back button color to white
        automaticallyImplyLeading: false, // Hide the back button
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Coach',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                itemCount: coaches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Radio(
                          value: coaches[index]['id'],
                          groupValue: selectedCoachID, // Provide a group value to handle radio button selection
                          onChanged: (value) {
                            setState(() {
                              selectedCoachID = value.toString(); // Update the selected coach ID when radio button is changed
                            });
                          },
                        ),
                        Text(
                          coaches[index]['name'] ?? '',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showSelectedCoach(); // Show the selected coach when button is pressed
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}