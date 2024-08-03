import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080/';
final EncryptedSharedPreferences _encryptedData= EncryptedSharedPreferences();

List <String> CoachName=['Hussein Rihan','kingza'];
class CoachesPage extends StatefulWidget {
  @override
  _CoachesPageState createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  String selectedCoach = '';



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
              'Coach Names',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void getCoach() async {
  try {
    print('try');
    String ID= await _encryptedData.getString('coachID');
    final response = await http
        .post(Uri.parse('$_baseURL/php/getCoach.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert
            .jsonEncode(<String, String>{'id': ID}))
        .timeout(const Duration(seconds: 5));
    print('try2');
    CoachName.clear();

    if (response.statusCode == 200) {
      print('nehna IF');
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse){
        CoachName.add("${row['Fname']} ${row['Lname']}");


      }


    }
  } catch (e) {
    print('hi');
    return ;
  }
}