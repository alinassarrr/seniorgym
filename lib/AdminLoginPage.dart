import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:seniorproject/NormalLoginPage.dart';
import 'package:seniorproject/trainee.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  String _selectedRole = 'Trainee'; // Default role
  final _formKey = GlobalKey<FormState>();

  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera);

    setState(() {
      _imageFile = pickedFile;
    });

    if (_imageFile != null) {
      print('Selected image: ${_imageFile!.name}');
    } else {
      print('No image selected.');
    }
  }


  Future<void> _uploadImage(String userID) async {
    if (_imageFile == null) return;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/php/upload_image.php'),
      )
        ..fields['userID'] = userID
        ..files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        // Read the response body
        final responseBody = await response.stream.bytesToString();
        final responseJson = convert.jsonDecode(responseBody);
        final message = responseJson['message'];

        print('Image uploaded successfully: $message');

        // Optionally, show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
      } else {
        // Read the response body
        final responseBody = await response.stream.bytesToString();
        final responseJson = convert.jsonDecode(responseBody);
        final error = responseJson['error'];

        print('Failed to upload image: $error');

        // Optionally, show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $error')),
        );
      }
    } catch (e) {
      print('Error occurred while uploading image: $e');

      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while uploading image')),
      );
    }
  }
  final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

  void logout() async {
    await _encryptedData.remove('adminID');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => NormalLoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed:logout , icon: Icon(Icons.logout))
        ],
        title: Center(
            child: Text('Admin Login', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 170,
                  height: 170,
                  color: Colors.blue,
                  child: _imageFile == null
                      ? Icon(Icons.camera)
                      : Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                ),
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
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
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
                            child: Text(value,
                              style: TextStyle(color: Colors.grey),),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Validating form fields
                            String userID = _userIDController.text;
                            String password = _passwordController.text;
                            String firstName = _firstNameController.text;
                            String lastName = _lastNameController.text;
                            String role = _selectedRole;

                            // Call function to create user
                            createUser(
                                userID, password, firstName, lastName, role);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40,
                              vertical: 20),
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

  // Method to create user
  void createUser(String userID, String password, String firstName,
      String lastName, String role) async {
    if (_imageFile == null) {
      // Show error dialog if no image is selected
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text('Please select an image before creating the user.'),
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
      return; // Exit the method if no image is selected
    }

    // First, create the user
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/php/create_user.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'id': userID,
        'pass': password,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = convert.jsonDecode(response.body);
      final message = responseBody['message'];

      // If user creation is successful, attempt to upload the image
      await _uploadImage(userID);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Success'),
              content: Text(message),
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
    } else {
      final errorResponse = convert.jsonDecode(response.body);
      final error = errorResponse['error'];

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text(error),
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
  }
}