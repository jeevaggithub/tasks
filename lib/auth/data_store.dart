import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:tasks/assets/variables.dart';
import 'package:tasks/screens/login.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> userDetailServer(BuildContext context, String name, String email,
    mobile, String password) async {
  var url = '$baseurl/signup';

  // var name = firstName + lastName;
  if (name == '') {
    print('name is empty' + name);
    return;
  } else if (email == '') {
    print('email is empty' + email);
    return;
  } else if (mobile == '') {
    print('mobile is empty' + mobile);
    return;
  } else if (password == '') {
    print('password is empty' + password);
    return;
  }

  var response = await http.post(
    Uri.parse(url),
    headers: {'content-type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
    }),
  );
  var res = jsonDecode(response.body)["message"];
  print(res);

  if (res == 'User is already exist') {
    print('${res}');
    const snackdemo = SnackBar(
      content: Text('User is already exist'),
      backgroundColor: Colors.redAccent,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  } else if (response.statusCode == 200 && res == 'registered successfuly') {
    // User already exists, show popup message
    print('${res}');
    const snackdemo = SnackBar(
      content: Text('User registered successfuly'),
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
            LoginPage(), // Replace with your Favorites screen widget
      ),
    );
  }
}
