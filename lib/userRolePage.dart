import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import this for HTTP requests

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String _message = '';

  void _login() async {
    final userID = _idController.text;
    final password = _passwordController.text;

    if (userID.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Please enter both User ID and Password';
      });
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/php/find.php'), // Ensure this URL is correct
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': userID,
          'pass': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success') {
          final role = jsonResponse['role'];
          final name = jsonResponse['Fname'];

          // Navigate based on user role
          if (role == 'trainee') {
            Navigator.of(context).pushReplacementNamed('/traineePage');
          } else if (role == 'coach') {
            Navigator.of(context).pushReplacementNamed('/coachPage');
          } else if (role == 'admin') {
            Navigator.of(context).pushReplacementNamed('/adminPage');
          }
        } else {
          setState(() {
            _message = 'Error: ${jsonResponse['message']}';
          });
        }
      } else {
        setState(() {
          _message = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Network or timeout error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'User ID',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? CircularProgressIndicator()
                  : Text('Login'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
