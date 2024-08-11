import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const String _baseURL = 'http://10.0.2.2:8080';
List<String> foodIDs = [];  // Stores the actual foodID from the database
List<String> breakfastOptions = [];  // Stores the names of the breakfast options
List<bool> selectedOptions = [];  // Tracks which options are selected

class BreakfastSuggestionsPage extends StatefulWidget {
  final String ID;

  BreakfastSuggestionsPage(this.ID);

  @override
  _BreakfastSuggestionsPageState createState() => _BreakfastSuggestionsPageState();
}

class _BreakfastSuggestionsPageState extends State<BreakfastSuggestionsPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getWeightLossBreakfast(() {
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          // Delete unchecked breakfast items
          for (int i = 0; i < breakfastOptions.length; i++) {
            if (!selectedOptions[i]) {
              await deleteAssignedFoods(widget.ID, [foodIDs[i]]);
            }
          }

          // Add checked breakfast items
          for (int i = 0; i < selectedOptions.length; i++) {
            if (selectedOptions[i]) {
              await addFood(widget.ID, foodIDs[i]);
            }
          }

          setState(() {
            isLoading = false;
          });
        },
        child: Icon(Icons.done),
        backgroundColor: Colors.white,
      ),
    );
  }

  void getWeightLossBreakfast(Function() refresh) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/getWeightLossBreakfast.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(const Duration(seconds: 5));

      foodIDs.clear();
      breakfastOptions.clear();
      selectedOptions.clear();

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        for (var row in jsonResponse) {
          // Print the foodID and name to the console for debugging
          print('foodID: ${row['foodID']}, name: ${row['name']}');

          // Add foodID and name to their respective lists
          foodIDs.add(row['foodID'].toString());  // Store the actual foodID
          breakfastOptions.add(row['name']);  // Store the name
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
        Uri.parse('$_baseURL/php/getAssignedBreakfastsWL.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{'id': userID}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> assignedFoods = convert.jsonDecode(response.body);

        // Reset selectedOptions to false
        selectedOptions = List.generate(breakfastOptions.length, (index) => false);

        // Match the foodID with the corresponding index in foodIDs
        for (var foodID in assignedFoods) {
          int index = foodIDs.indexOf(foodID.toString());
          if (index >= 0 && index < breakfastOptions.length) {
            selectedOptions[index] = true;
          }
        }

        refresh();
      } else {
        print('Failed to get assigned foods: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> addFood(String userID, String foodID) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/addBreakfastWL.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(
            <String, String>{'id': userID, 'foodID': foodID}),
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

  Future<void> deleteAssignedFoods(String userID, List<String> foodIDs) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/php/deleteBreakfastWL.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, dynamic>{
          'id': userID,
          'foodIDs': foodIDs
        }),
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
