import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MealDietPage extends StatefulWidget {
  final String userID;
  final String dateAssigned;
  final String mealTime;

  MealDietPage({required this.userID, required this.dateAssigned, required this.mealTime});

  @override
  _MealDietPageState createState() => _MealDietPageState();
}

class _MealDietPageState extends State<MealDietPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> foods = [];

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/php/getFoodsAssigned.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{
          'id': widget.userID,
          'dateAssigned': widget.dateAssigned,
          'mealTime': widget.mealTime,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);

        // Check if 'foods' is present and is a list
        if (jsonResponse != null && jsonResponse['foods'] is List) {
          setState(() {
            foods = (jsonResponse['foods'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList();
            isLoading = false;
          });
        } else {
          setState(() {
            foods = [];
            isLoading = false;
          });
          print('No foods found or response structure is invalid.');
        }
      } else {
        print('Failed to load foods: ${response.statusCode}');
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
          '${widget.mealTime} for ${widget.dateAssigned}',
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
          : foods.isEmpty
          ? Center(
        child: Text(
          'No ${widget.mealTime} foods assigned for this date.',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return ListTile(
            leading: Icon(
              Icons.fastfood, // Replace with the icon you want
              color: Colors.white,
            ),
            title: Text(
              food['foodName'],
              style: TextStyle(color: Colors.white,fontSize: 22),
            ),
          );
        },
      ),
    );
  }
}