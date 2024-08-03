import 'package:flutter/material.dart';
import 'traineeMealPage.dart';

class SnacksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Snacks',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        centerTitle: true, // Center align the title
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print('Sweet');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealPage(mealType: 'Sweet')),
                );
              },
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sweetSnack.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Sweet',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {
                print('Sour');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealPage(mealType: 'Sour')),
                );
              },
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sourSnacks.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Sour',
                    style: TextStyle(fontSize: 20, color: Colors.red),
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
