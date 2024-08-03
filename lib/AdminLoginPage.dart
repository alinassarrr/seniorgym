import 'dart:io'; // Import 'dart:io' instead of 'dart:html'
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  File? _selectedImage; // Declare _selectedImage as a File object
  String _selectedRole = 'Trainee'; // Default role
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin Login', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
                color: Colors.blue, // Example color, replace with your image
                child: _selectedImage != null
                    ? Image.file(_selectedImage!) // Show selected image if available
                    : Icon(Icons.camera), // Show camera icon if no image is selected
              ),
              SizedBox(height: 20),
              Text(
                'Gym Credentials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userIDController,
                        decoration: InputDecoration(
                          labelText: 'User ID',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter User ID';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        items: <String>['Trainee', 'Coach', 'Admin']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Role',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _pickImageFromCamera, // Call the _takePicture method when pressed
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        ),
                        child: Text(
                          'Take Picture',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10), // Add some spacing
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Validating form fields
                            String userID = _userIDController.text;
                            String password = _passwordController.text;
                            // Do something with the user ID, password, and role
                            // For now, let's show a dialog indicating success
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Success'),
                                content: Text('Account created successfully!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Method to handle taking a picture
  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
