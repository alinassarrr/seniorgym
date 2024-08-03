import 'package:flutter/material.dart';
import '5coachWeightGainMealOptionsPage.dart';
import '9coachWeightLossMealOptionsPage.dart';
import '13coachSnacksOptionsPage.dart';

class MealAssignmentPage extends StatefulWidget {
  final String ID;

  MealAssignmentPage(this.ID);

  @override
  _MealAssignmentPageState createState() => _MealAssignmentPageState();
}

class _MealAssignmentPageState extends State<MealAssignmentPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.ID);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assign Meal',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeightGainMealOptionsPage(widget.ID)), // Navigate to Weight Gain Meal Options page
                );
              },
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
                    image: AssetImage('assets/weightgain.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Weight Gain',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeightLossMealOptionsPage(widget.ID)), // Navigate to Weight Loss Meal Options page
                );
              },
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
                    image: AssetImage('assets/weightloss.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Weight Loss',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SnacksOptionsPage(widget.ID)), // Navigate to Snacks Meal Options page
                );
              },
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
                    image: AssetImage('assets/snacks.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Snacks',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}