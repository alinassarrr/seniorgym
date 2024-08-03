import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String photoPath;
  final String description;
  final String exerciseName; // New field to store exercise name

  const ExercisePage({
    Key? key,
    required this.photoPath,
    required this.description,
    required this.exerciseName, // Initialize exerciseName in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exerciseName, // Use exerciseName as the title
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:500,// Set width to screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                photoPath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
