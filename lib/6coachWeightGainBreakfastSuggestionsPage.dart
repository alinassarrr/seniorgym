import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://seniorproject30.000webhostapp.com/';
final EncryptedSharedPreferences _encryptedData= EncryptedSharedPreferences();
List<String> breakfastOptions = [
  'Oatmeal with fruits',
  'Scrambled eggs with toast',
  'Greek yogurt with granola',
];
List<bool> selectedOptions = [];
class BreakfastSuggestionsPage extends StatefulWidget {
  String ID;

  BreakfastSuggestionsPage(this.ID);

  @override
  _BreakfastSuggestionsPageState createState() => _BreakfastSuggestionsPageState();
}

class _BreakfastSuggestionsPageState extends State<BreakfastSuggestionsPage> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakfast Suggestions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: breakfastOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              breakfastOptions[index],
              style: TextStyle(color: Colors.white),
            ),
            value: selectedOptions[index],
            onChanged: (value) {
              setState(() {
                selectedOptions[index] = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
            checkColor: Colors.white,
            activeColor: Colors.green, // Color when selected
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle "Done" button press
          List<String> selectedFoods = [];
          for (int i = 0; i < breakfastOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(breakfastOptions[i]);
            }
          }
          // You can use the selectedFoods list for further processing
          // For example, sending the selected foods to the user
          Navigator.of(context).pop();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

void getWeightGainBreakfast(Function() refresh ) async {
  try {
    await Future.delayed(Duration(seconds: 1));
    String name= await _encryptedData.getString('name');
    final response = await http
        .post(Uri.parse('$_baseURL/getWeightGainBreakfast.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert
            .jsonEncode(<String, String>{'name': name}))
        .timeout(const Duration(seconds: 5));

    breakfastOptions.clear();

    if (response.statusCode == 200) {

      print(response.body);
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse){
        breakfastOptions.add("${row['name']}");


      }
      refresh();


    }
  } catch (e) {
    print('hi');
    print(e);
    return ;
  }
}
