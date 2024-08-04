import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080/';
final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

List<String> CoachName = [];

class CoachesPage extends StatefulWidget {
  @override
  _CoachesPageState createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  String selectedCoach = '';

  @override
  void initState() {
    super.initState();
    getCoach();
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
          CoachName.clear();
          for (var row in jsonResponse) {
            CoachName.add("${row['Fname']} ${row['Lname']}");
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
          content: Text(selectedCoach.isNotEmpty ? selectedCoach : 'No coach selected'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Coach',
              style: TextStyle(fontSize: 24, color: Colors.white,fontWeight:FontWeight.w700),
            ),
            SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                itemCount: CoachName.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Radio(
                          value: CoachName[index],
                          groupValue: selectedCoach, // Provide a group value to handle radio button selection
                          onChanged: (value) {
                            setState(() {
                              selectedCoach = value.toString(); // Update the selected coach when radio button is changed
                            });
                          },
                        ),
                        Text(
                          CoachName[index],
                          style: TextStyle(color: Colors.white, fontWeight:FontWeight.w400,fontSize: 20 ),
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
