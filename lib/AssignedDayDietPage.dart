import 'package:flutter/material.dart';
import 'MealDietPage.dart';
import 'SnackDietPage.dart';
class AssignedDayDietPage extends StatelessWidget {
  final String userID;
  final String dateAssigned;

  AssignedDayDietPage({required this.userID, required this.dateAssigned});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diet for $dateAssigned',
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMealOption(
                context,
                'Breakfast',
                'assets/weightGainBreakfast.jpg',
                'breakfast',
              ),
              SizedBox(height: 20),
              _buildMealOption(
                context,
                'Lunch',
                'assets/weightGainLunch.jpg',
                'lunch',
              ),
              SizedBox(height: 20),
              _buildMealOption(
                context,
                'Dinner',
                'assets/weightLossDinner.jpg',
                'dinner',
              ),
              SizedBox(height: 20),
              _buildSnackOption(
                context,
                'Snacks',
                'assets/snacks.jpg', // Replace with your snacks image
                'snacks',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealOption(BuildContext context, String mealName, String imagePath, String mealTime) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDietPage(
              userID: userID,
              dateAssigned: dateAssigned,
              mealTime: mealTime,
            ),
          ),
        );
      },
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            mealName,
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSnackOption(BuildContext context, String mealName, String imagePath, String foodType) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnackDietPage(
              userID: userID,
              dateAssigned: dateAssigned,
              foodType: foodType,
            ),
          ),
        );
      },
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            mealName,
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
