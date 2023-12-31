import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

import 'package:tasks/auth/data_retrive.dart';
import 'package:tasks/assets/variables.dart';
import 'package:tasks/main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void Function(List<Map<String, dynamic>>)? onDataUpdated;

void updateTaskLists(List<Map<String, dynamic>> responseData,
    Function(List<Map<String, dynamic>>) callback) {
  GlobalTaskLists = responseData; // Update the global variable
  callback(GlobalTaskLists);
  print(GlobalTaskLists);

  GlobalTaskLists = responseData; // Update the global variable

  // Call the callback function to update UI
  onDataUpdated!(GlobalTaskLists);
}

Future<List<Map<String, dynamic>>> getTasks(String userId) async {
  try {
    var url = '$baseurl/user/$userId/tasks';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      // Convert responseData to the correct type
      List<Map<String, dynamic>> taskListData =
          responseData.cast<Map<String, dynamic>>();

      return taskListData; // Return the fetched data
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load tasks');
    }
  } catch (error) {
    print('Error making GET request: $error');
    throw Exception('Failed to load tasks');
  }
}

Future<List<Map<String, dynamic>>> getTask(String taskId) async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? '';
  try {
    var url = '$baseurl/user/$userId/tasks/$taskId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      // Convert responseData to the correct type
      List<Map<String, dynamic>> taskData =
          responseData.cast<Map<String, dynamic>>();

      return taskData; // Return the fetched data
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load tasks');
    }
  } catch (error) {
    print('Error making GET request: $error');
    throw Exception('Failed to load tasks');
  }
}

Future<void> newTaskList(BuildContext context, String title) async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? '';
  // print('userId from newTaskList' + userId);
  // print('title from newTaskList' + title);
  try {
    var url = '$baseurl/tasklists';
    if (title == '') {
      print('name is empty' + title);
      return;
    }
    var response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'title': title,
      }),
    );
    var res = jsonDecode(response.body)["message"];
    print(res);

    if (response.statusCode == 201 &&
        res == 'Task list created and associated with user') {
      // Navigate to the home screen or any other screen you want
      await getTasks(userId);

      // Push a new HomeScreen to replace the current one
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      print('something wrong in the response');
    }
  } catch (error) {
    print('Error making GET request: $error');
  }
}

//Delete task list
Future<void> deleteTaskList(BuildContext context, String tasklistid) async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? '';
  if (tasklistid == '') {
    print('name is empty' + tasklistid);
    return;
  }
  try {
    var url = '$baseurl/deletelist/$userId/$tasklistid';

    final response = await http.delete(Uri.parse(url));

    var res = jsonDecode(response.body)["message"];
    print(res);

    if (response.statusCode == 200 && res == 'Task list deleted') {
      // Navigate to the home screen or any other screen you want
      await getTasks(userId);

      // Push a new HomeScreen to replace the current one
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      print('something wrong in the response');
    }
  } catch (error) {
    print('Error making GET request: $error');
  }
}

//Delete task
Future<void> deleteTask(BuildContext context, String taskid) async {
  // final prefs = await SharedPreferences.getInstance();
  // userId = prefs.getString('userId') ?? '';
  if (taskid == '') {
    print('name is empty' + taskid);
    return;
  }
  try {
    print('delete task id is : $taskid');
    print('delete userId id is : $userId');
    var url = '$baseurl/deletetask/$taskid';

    final response = await http.delete(Uri.parse(url));

    var res = jsonDecode(response.body)["message"];
    print(res);

    if (response.statusCode == 200 && res == 'Task deleted') {
      // Navigate to the home screen or any other screen you want
      await getTasks(userId);

      // Push a new HomeScreen to replace the current one
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
      const snackdemo = SnackBar(
        content: Text(
          'Task deleted successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      print('something wrong in the response');
    }
  } catch (error) {
    print('Error making GET request: $error');
  }
}

//New task api
Future<void> newTask(
  BuildContext context,
  String title,
  String taskListId,
  String desc,
  dueDate,
) async {
  // Create a DateTime object
  // DateTime dueDate = DateTime.now();
  print('printing dueDate from newTask : $dueDate ');
// Format the DateTime object as a string
  String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dueDate);
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId') ?? '';
  // print('userId from newTaskList' + userId);
  // print('title from newTaskList' + title);
  try {
    var url = '$baseurl/tasks';
    if (title == '') {
      print('name is empty' + title);
      return;
    }
    var response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'taskListId': taskListId,
        'title': title,
        'description': desc,
        'dueDate': formattedDateTime,
      }),
    );
    var res = jsonDecode(response.body)["message"];
    print(res);

    if (response.statusCode == 201 &&
        res == 'Task created and associated with task list') {
      // Navigate to the home screen or any other screen you want
      getTasks(userId);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
      var snackdemo = SnackBar(
        content: Text(
          'Task $title created successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      print('something wrong in the response');
    }
  } catch (error) {
    print('Error making GET request: $error');
  }
}
