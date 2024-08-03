import 'package:flutter/material.dart';

class BreakfastSuggestionsPage extends StatefulWidget {
  String ID;

  BreakfastSuggestionsPage(this.ID);

  @override
  _BreakfastSuggestionsPageState createState() => _BreakfastSuggestionsPageState();
}

class _BreakfastSuggestionsPageState extends State<BreakfastSuggestionsPage> {
  List<String> breakfastOptions = [
    'Avocado toast with poached egg',
    'Green smoothie with spinach and banana',
    'Whole grain cereal with almond milk',
  ];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    selectedOptions = List<bool>.filled(breakfastOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakfast Suggestions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: breakfastOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              breakfastOptions[index],
              style: TextStyle(color: Colors.white),
            ),
            value: selectedOptions[index],
            onChanged: (value) {
              setState(() {
                selectedOptions[index] = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
            checkColor: Colors.white,
            activeColor: Colors.green, // Color when selected
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle "Done" button press
          List<String> selectedFoods = [];
          for (int i = 0; i < breakfastOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(breakfastOptions[i]);
            }
          }
          // You can use the selectedFoods list for further processing
          // For example, sending the selected foods to the user
          Navigator.of(context).pop();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
