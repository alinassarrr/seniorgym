import 'package:flutter/material.dart';

class DinnerSuggestionsPage extends StatefulWidget {
  String ID;

  DinnerSuggestionsPage(this.ID);
  @override
  _DinnerSuggestionsPageState createState() => _DinnerSuggestionsPageState();
}

class _DinnerSuggestionsPageState extends State<DinnerSuggestionsPage> {
  List<String> dinnerOptions = [
    'Grilled fish with steamed vegetables',
    'Vegetable stir-fry with tofu',
    'Baked chicken with roasted sweet potatoes',
  ];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    selectedOptions = List<bool>.filled(dinnerOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dinner Suggestions',
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
        itemCount: dinnerOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              dinnerOptions[index],
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
          for (int i = 0; i < dinnerOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(dinnerOptions[i]);
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
