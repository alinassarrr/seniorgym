import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080';
final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();
List<String> breakfastOptions = [];
List<bool> selectedOptions = [];

class BreakfastSuggestionsPage extends StatefulWidget {
  final String ID;

  BreakfastSuggestionsPage(this.ID);

  @override
  _BreakfastSuggestionsPageState createState() => _BreakfastSuggestionsPageState();
}

class _BreakfastSuggestionsPageState extends State<BreakfastSuggestionsPage> {
  @override
  void initState() {
    super.initState();
    getWeightGainBreakfast(() {
      getAssignedFoods(widget.ID, () {
        setState(() {}); // Refresh the UI after fetching the data
      });
    });
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
        backgroundColor: Colors.black,
        leading: IconButton(
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
            activeColor: Colors.green,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> selectedFoodIDs = [];
          for (int i = 0; i < breakfastOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoodIDs.add('${i + 1}'); // Ensure this is consistent with your backend
            }
          }

          deleteAssignedFoods(widget.ID, selectedFoodIDs);
          for (String foodID in selectedFoodIDs) {
            addFood(widget.ID, foodID);
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }

  void getWeightGainBreakfast(Function() refresh) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      String name = await _encryptedData.getString('name');
      final response = await http
          .post(Uri.parse('$_baseURL/php/getWeightGainBreakfast.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: convert.jsonEncode(<String, String>{'name': name}))
          .timeout(const Duration(seconds: 5));

      breakfastOptions.clear();
      selectedOptions.clear();

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        for (var row in jsonResponse) {
          breakfastOptions.add("${row['name']}");
        }
        selectedOptions = List.generate(breakfastOptions.length, (index) => false);
        refresh();
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void getAssignedFoods(String userID, Function() refresh) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/getAssignedBreakfasts.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> assignedFoods = convert.jsonDecode(response.body);
        selectedOptions = List.generate(breakfastOptions.length, (index) {
          // Assuming the assigned food IDs are strings in the response
          return assignedFoods.contains('${index + 1}');
        });
        refresh();
      } else {
        print('Failed to get assigned foods: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void addFood(String userID, String foodID) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/addFood.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID, 'foodID': foodID}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        print('Food added: ${response.body}');
      } else {
        print('Failed to add food: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void deleteAssignedFoods(String userID, List<String> foodIDs) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/deleteFood.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, dynamic>{'id': userID, 'foodIDs': foodIDs}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        print('Foods deleted: ${response.body}');
      } else {
        print('Failed to delete foods: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
