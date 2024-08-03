// 15coachSourSnacksSuggestionsPage.dart
import 'package:flutter/material.dart';

class SourSnacksSuggestionsPage extends StatefulWidget {
  String ID;

  SourSnacksSuggestionsPage(this.ID);

  @override
  _SourSnacksSuggestionsPageState createState() =>
      _SourSnacksSuggestionsPageState();
}

class _SourSnacksSuggestionsPageState
    extends State<SourSnacksSuggestionsPage> {
  List<String> sourSnacksOptions = [
    'Greek yogurt with lemon zest',
    'Apple slices with lemon juice',
    'Pickles',
  ];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    selectedOptions =
    List<bool>.filled(sourSnacksOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sour Snacks Suggestions',
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
        itemCount: sourSnacksOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              sourSnacksOptions[index],
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
          for (int i = 0; i < sourSnacksOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(sourSnacksOptions[i]);
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
