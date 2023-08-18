import 'package:flutter/material.dart';
import 'package:tasks/screens/login.dart';

import 'package:tasks/auth/data_store.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle _custext = TextStyle(color: Colors.white, fontSize: 15);

  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here
      // For now, just print the form data
      print('Name: $_name');
      print('Email: $_email');
      print('Phone: $_phone');
      print('Password: $_password');
      print('confirmPassword: $_confirmPassword');

      userDetailServer(
        context,
        _name,
        _email,
        _phone,
        _password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/background_image.jpg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.black.withOpacity(0.7),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                        ),
                        onChanged: (value) {
                          _name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        style: _custext,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                        ),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add email validation logic here
                          return null;
                        },
                        style: _custext,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                        ),
                        onChanged: (value) {
                          _phone = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // You can add phone validation logic here
                          return null;
                        },
                        style: _custext,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        style: _custext,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: Colors.blue, // Set the label text color
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value; // Update _confirmPassword
                          });
                        },
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        style: _custext,
                      ),
                      // SizedBox(height: 10.0),
                      // TextFormField(
                      //   decoration:
                      //       InputDecoration(labelText: 'Confirm Password'),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _confirmPassword = value; // Update _confirmPassword
                      //     });
                      //   },
                      //   obscureText: true,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please confirm your password';
                      //     }
                      //     if (value != _password) {
                      //       return 'Passwords do not match';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Register'),
                      ),
                      Row(
                        children: [
                          Text(
                            'Already our user ? then ',
                            style: _custext,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage(), // Replace with your Favorites screen widget
                                ),
                              );
                            },
                            child: Text(
                              'Login',
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
