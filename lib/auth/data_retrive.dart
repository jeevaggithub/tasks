import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tasks/assets/variables.dart';
import 'package:tasks/main.dart';

String userName = '';
String userId = '';
String userEmail = '';
String userMobile = '';
String TokenRef = '';

Future<void> LocalUser(email) async {
  // String userName = '';
  // String userId = '';
  // String userEmail = '';
  // String userMobile = '';
  var url = '$baseurl/user';
  var response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $TokenRef', // Use the token you've saved
    }, // Set the correct origin header
    body: jsonEncode({
      'email': email,
    }),
  );

  Map<String, dynamic> localStorage = jsonDecode(response.body);
  // Map<String, dynamic> user = localStorage['User'];
  Map<String, dynamic> userFinal = localStorage['User'];

  print('final user http' + userFinal['name']);

  userId = userFinal['_id'];
  userName = userFinal['name'];
  userEmail = userFinal['email'];
  userMobile = userFinal['mobile'];
  // TokenRef = userFinal['jwtToken'];

  // Store user details securely
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('userId', userId);
  prefs.setString('userName', userName);
  prefs.setString('userEmail', userEmail);
  prefs.setString('userMobile', userMobile);
  // prefs.getString('jwtToken') ?? TokenRef;

  print('userId: drt $userId');
  print('userName: drt $userName');
  print('userEmail: drt $userEmail');
  print('userMobile: drt $userMobile');
  print('TokenRef: drt $TokenRef');
}

Future<void> userlogin(context, email, password) async {
  var url = '$baseurl/signin';

  var response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token',
    }, // Set the correct origin header
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );
  const emailerr = 'Invalid email';
  var res = jsonDecode(response.body)["message"];
  print(res);
  // print('ytbiiiy   ${res}');
  print(response.statusCode);
  // print((response));
  if (response.statusCode == 401 && res == emailerr) {
    print('err${res}');
    const snackdemo = SnackBar(
      content: Text('User does not exist'),
      backgroundColor: Colors.redAccent,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  } else if (response.statusCode == 401 && res == 'Invalid password') {
    print(res);
    const snackdemo = SnackBar(
      content: Text('password does not match'),
      backgroundColor: Colors.redAccent,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  } else if (response.statusCode == 200 && res == 'user authenticated') {
    print(res);

    // Parse JWT from response
    TokenRef = jsonDecode(response.body)["token"];

    // Store token securely
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwtToken', TokenRef);
    // print('iginig Token    ' + token);

    const snackdemo = SnackBar(
      content: Text('LoggedIn successfuly'),
      backgroundColor: Colors.blueAccent,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    await LocalUser(email);
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }
}
