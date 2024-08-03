import 'package:flutter/material.dart';
import '14coachSweetSnacksSuggestionsPage.dart'; // Import Sweet Snacks suggestions page
import '15coachSourSnacksSuggestionsPage.dart'; // Import Sour Snacks suggestions page

class SnacksOptionsPage extends StatelessWidget {
  String ID;

  SnacksOptionsPage(this.ID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Snacks',
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
                // Navigate to Sweet Snacks suggestions page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SweetSnacksSuggestionsPage(ID),
                  ),
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
                    image: AssetImage('assets/sweetSnack.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sweet Snacks',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Sour Snacks suggestions page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SourSnacksSuggestionsPage(ID),
                  ),
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
                    image: AssetImage('assets/sourSnacks.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sour Snacks',
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
