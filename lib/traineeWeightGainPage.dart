import 'package:flutter/material.dart';
import 'traineeMealPage.dart';

class WeightGainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weight Gain',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        centerTitle: true, // Center align the title
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print('Breakfast');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealPage(mealType: 'Breakfast', foodType: 'weightgain')),
                  );
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/weightGainBreakfast.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Breakfast',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  print('Lunch');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealPage(mealType: 'Lunch', foodType: 'weightgain')),
                  );
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/weightGainLunch.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Lunch',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  print('Dinner');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealPage(mealType: 'Dinner', foodType: 'weightgain')),
                  );
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/weightGainDinner.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Dinner',
                      style: TextStyle(fontSize: 24, color: Colors.white),
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
