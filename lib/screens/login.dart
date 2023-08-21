import 'package:flutter/material.dart';
import 'package:tasks/auth/data_retrive.dart';
import 'package:tasks/screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      // For now, just print the email and password
      print('Email: $_email');
      print('Password: $_password');
      userlogin(context, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/background_image2.jpg'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.black.withOpacity(
                    0.7), // Add a semi-transparent background color
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more validation here if needed
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          // You can add more validation here if needed
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Login'),
                      ),
                      Row(
                        children: [
                          Text(
                            'New user ? then ',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage(), // Replace with your Favorites screen widget
                                ),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 229, 107, 245),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
