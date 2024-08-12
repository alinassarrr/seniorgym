import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MealPage extends StatefulWidget {
  final String mealType;
  final String foodType;

  MealPage({required this.mealType, required this.foodType});

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
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
        Uri.parse('http://10.0.2.2:8080/php/getMeals.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, String>{
          'foodType': widget.foodType,
          'mealTime': widget.mealType,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);

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
          '${widget.mealType} for Weight Gain',
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
          'No ${widget.mealType} foods found for this type.',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return ListTile(
            leading: Icon(
              Icons.fastfood, // You can choose a more relevant icon
              color: Colors.white,
            ),
            title: Text(
              food['name'], // Assuming the food name is returned as 'name'
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
