import 'package:flutter/material.dart';
import 'trainee.dart';
import '1coach.dart';
import 'AdminLoginPage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

const String _baseURL = 'http://10.0.2.2:8080/';
final EncryptedSharedPreferences _encryptedData= EncryptedSharedPreferences();

class NormalLoginPage extends StatefulWidget {
  @override
  _NormalLoginPageState createState() => _NormalLoginPageState();
}

class _NormalLoginPageState extends State<NormalLoginPage> {
  bool _loading=false;
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void load(){

    setState(() {
      _loading=false;
    });

  }
  void saveData(String id,String role,String name){

    if (role == 'trainee') {
      _encryptedData.setString('traineeID', id);
      _encryptedData.setString('name', name);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else if (role == 'coach') {
      _encryptedData.setString('coachID', id);
      _encryptedData.setString('name', name);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CoachFrontend()),
      );
    } else if (role == 'admin') {
      _encryptedData.setString('adminID', id);
      _encryptedData.setString('name', name);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginPage()),
      );
    }
    setState(() {
      _loading=false;

    });

  }
  void checkSavedData()async{
    await _encryptedData.getString('traineeID').then((String value) {
      if(value.isNotEmpty){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    }
    );
    await _encryptedData.getString('coachID').then((String value) {
      if(value.isNotEmpty){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoachFrontend()),
        );
      }
    }
    );
    await _encryptedData.getString('adminID').then((String value) {
      if(value.isNotEmpty){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminLoginPage()),
        );
      }
    });
  }
  void initState(){
    super.initState();
    checkSavedData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Normal Login', style: TextStyle(color: Colors.white))),
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
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Image.asset('assets/GymLogo.jpg'),
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
                        decoration:const InputDecoration(
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

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loading?null:() {
                          if (_formKey.currentState!.validate()) {
                            // Validating form fields
                            String userID = _userIDController.text;
                            String password = _passwordController.text;
                            setState(() {
                              _loading=true;
                            });
                            checkLogin(saveData,load,userID, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Visibility(visible: _loading,child: CircularProgressIndicator())
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
}
void checkLogin(Function(String id, String role, String name) saveData,
     Function() load,String ID, String password) async {
  try {
    final response = await http
        .post(Uri.parse('$_baseURL/php/login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert
            .jsonEncode(<String, String>{'id': ID, 'pass': password}))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      saveData(row['userID'],row['role'],row['Fname']);
    }
  } catch (e) {
    load();
    print(e);
  }
}
