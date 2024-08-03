// 14coachSweetSnacksSuggestionsPage.dart
import 'package:flutter/material.dart';

class SweetSnacksSuggestionsPage extends StatefulWidget {
  String ID;

  SweetSnacksSuggestionsPage(this.ID);

  @override
  _SweetSnacksSuggestionsPageState createState() =>
      _SweetSnacksSuggestionsPageState();
}

class _SweetSnacksSuggestionsPageState
    extends State<SweetSnacksSuggestionsPage> {
  List<String> sweetSnacksOptions = [
    'Fruit salad',
    'Yogurt parfait with honey',
    'Dark chocolate covered almonds',
  ];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    selectedOptions =
    List<bool>.filled(sweetSnacksOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sweet Snacks Suggestions',
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
      body: ListView.builder(
        itemCount: sweetSnacksOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              sweetSnacksOptions[index],
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
          for (int i = 0; i < sweetSnacksOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(sweetSnacksOptions[i]);
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
