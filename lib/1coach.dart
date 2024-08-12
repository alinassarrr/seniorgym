import 'package:flutter/material.dart';
import 'package:seniorproject/NormalLoginPage.dart';
import '2coachAssigning.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080/';
final EncryptedSharedPreferences _encryptedData= EncryptedSharedPreferences();
List <String> TraineeName=[''];
List <String> TraineeDate=[''];
List <String> TraineeID=[''];


class CoachFrontend extends StatefulWidget {
  const CoachFrontend({Key? key}) : super(key: key);

  @override
  State<CoachFrontend> createState() => _CoachFrontendState();
}

class _CoachFrontendState extends State<CoachFrontend> {
  @override
  void initState() {
    super.initState();
    refresh();
    getTrainee(refresh);
  }

  void refresh(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            _encryptedData.remove('coachID');
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NormalLoginPage()));
          }, icon: Icon(Icons.logout)),
          IconButton(onPressed: (){
            getTrainee(refresh);


          }, icon: Icon(Icons.refresh))
        ],
        title: Text(
          'Coach Dashboard',
          style: TextStyle(color: Colors.white), // Title color
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.black, // Background color
      ),
      backgroundColor: Colors.white,

      body: ListView.builder(
        itemCount: TraineeName.length, // Number of trainees
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TraineeDetailPage(traineeName: TraineeName[index],ID: TraineeID[index]),
                      ),
                    );
                  },
                  child: Container(
                    height: 120, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/coachtraineelist.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            TraineeName[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            TraineeDate[index],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Add vertical space between buttons
              ],
            ),
          );
        },
      ),
    );
  }
}
void getTrainee(Function() refresh ) async {
  try {

    String ID= await _encryptedData.getString('coachID');
    final response = await http
        .post(Uri.parse('$_baseURL/php/getTrainee.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert
            .jsonEncode(<String, String>{'id': ID}))
        .timeout(const Duration(seconds: 5));

    TraineeName.clear();
    TraineeDate.clear();
    TraineeID.clear();
    if (response.statusCode == 200) {

      print(response.body);
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse){
        TraineeName.add("${row['Fname']} ${row['Lname']}");
        TraineeDate.add(row['date']);
        TraineeID.add(row['userID']);

            }
      refresh();


    }
  } catch (e) {
    print('hi');
    print(e);
    return ;
  }
}
