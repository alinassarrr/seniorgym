import 'package:flutter/material.dart';
import 'DietForTodayPage.dart';
import 'AssignedExercisesPage.dart';
import 'TraineeActivityLogPage.dart';
class TraineeOptionsPage extends StatelessWidget {
  final String userID;

  TraineeOptionsPage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Assigned By Coach',
            style: TextStyle(color: Colors.white),  // Set the text color to white
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the Assigned Exercises page and pass the userID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignedExercisesPage(userID: userID),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/test.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Assigned Exercises',
                      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the Diet for Today page and pass the userID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DietForTodayPage(userID: userID),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/weightloss.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Your Diet for Today',
                      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to the Activity Log page and pass the userID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityLogPage(userID: userID),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/detected.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Activity Log',
                      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
