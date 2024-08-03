import 'package:flutter/material.dart';

class MealPage extends StatelessWidget {
  final String mealType;

  MealPage({required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealType),
      ),
      body: Center(
        child: Text(
          'This is the $mealType page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
