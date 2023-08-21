import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tasks/assets/variables.dart';
import 'package:tasks/main.dart';

Future<void> userlogin(context, email, password) async {
  var url = '$baseurl/signin';

  var response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json'
    }, // Set the correct origin header
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );
  const emailerr = 'Invalid email';
  var res = jsonDecode(response.body)["message"];
  print(res);
  print('ytbiiiy   ${res}');
  print(response.statusCode);
  // print((response));
  if (response.statusCode == 401 && res == emailerr) {
    print('ygbufuufu${res}');
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

    const snackdemo = SnackBar(
      content: Text('LoggedIn successfuly'),
      backgroundColor: Colors.blueAccent,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            HomeScreen(), // Replace with your Favorites screen widget
      ),
    );
  }
}
