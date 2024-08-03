import 'package:flutter/material.dart';

class LunchSuggestionsPage extends StatefulWidget {
  String ID;

  LunchSuggestionsPage(this.ID);

  @override
  _LunchSuggestionsPageState createState() => _LunchSuggestionsPageState();
}

class _LunchSuggestionsPageState extends State<LunchSuggestionsPage> {
  List<String> lunchOptions = [
    'Grilled vegetable wrap',
    'Quinoa salad with black beans',
    'Turkey and avocado wrap',
  ];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    selectedOptions = List<bool>.filled(lunchOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lunch Suggestions',
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
        itemCount: lunchOptions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              lunchOptions[index],
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
          for (int i = 0; i < lunchOptions.length; i++) {
            if (selectedOptions[i]) {
              selectedFoods.add(lunchOptions[i]);
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
