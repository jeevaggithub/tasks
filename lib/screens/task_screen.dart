import 'package:flutter/material.dart';
import 'package:tasks/auth/task_manager.dart';
import 'package:tasks/services/noti_service.dart';
import 'dart:convert';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final String dueDate;
  final NotificationService notificationService = NotificationService();
  TaskScreen({
    Key? key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int notiId = 0;
  late int tempShId;
  late NotificationService notificationService;
  bool _notiBtn = false;
  bool isFuture = false;
  late DateTime parsedDateTime;

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService();
    notificationService.initNotification();
    parsedDateTime = _parseDateTime(widget.dueDate);
    isFuture = isDateTimeInFuture(parsedDateTime);
  }

  _parseDateTime(dateTimeString) {
    // Define a map to map month abbreviations to numerical values
    Map<String, int> monthAbbreviationToNumber = {
      'Jan': DateTime.january,
      'Feb': DateTime.february,
      'Mar': DateTime.march,
      'Apr': DateTime.april,
      'May': DateTime.may,
      'Jun': DateTime.june,
      'Jul': DateTime.july,
      'Aug': DateTime.august,
      'Sep': DateTime.september,
      'Oct': DateTime.october,
      'Nov': DateTime.november,
      'Dec': DateTime.december,
    };
    // Split the date string into parts
    List<String> parts = dateTimeString.split(' ');

// Extract relevant date and time components
    // String dayOfWeek = parts[0]; // e.g., "Wed"
    String monthAbbreviation = parts[1]; // e.g., "Sep"
    int day = int.parse(parts[2]); // e.g., 27
    int year = int.parse(parts[3]); // e.g., 2023
    String time = parts[4]; // e.g., "14:00:00"

// Parse the time part into hours and minutes
    List<String> timeParts = time.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Map the month abbreviation to its numerical value
    int? month = monthAbbreviationToNumber[monthAbbreviation];

// Create a DateTime object
    DateTime parsedDateTime = DateTime(
      year,
      month ?? 1,
      day,
      hours,
      minutes,
    );
    return parsedDateTime;
  }

  bool isDateTimeInFuture(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.isAfter(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TaskId : ',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  widget.taskId,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Name : ',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 200,
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task description : ',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 200.0,
                  child: Text(
                    widget.description,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date&Time : ',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 200,
                  child: Text(
                    // Format the date and time here
                    // DateFormat('yyyy-MM-dd  HH:mm:ss')
                    //     .format(DateTime.parse(widget.dueDate)),
                    widget.dueDate,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150.0,
                  color:
                      !_notiBtn && isFuture ? Colors.greenAccent : Colors.blue,
                  child: TextButton.icon(
                      // style: Colors.blue,
                      onPressed: () {
                        print('parsedDateTime : $parsedDateTime');
                        print('isFuture : $isFuture');
                        // isFuture = isDateTimeInFuture(parsedDateTime);

                        if (!isFuture) {
                          const snackdemo = SnackBar(
                            content: Text('cannot notify for past'),
                            backgroundColor: Colors.redAccent,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                          return;
                        }

                        if (!_notiBtn && isFuture) {
                          print(_notiBtn);
                          print(
                              ' date and time from task screen ${widget.dueDate}');
                          notificationService.scheduleNotification(
                            id: notiId,
                            title: widget.title,
                            body: widget.description,
                            taskId: widget.taskId,
                            desc: widget.description,
                            dueDate: parsedDateTime,
                            payload: jsonEncode({
                              'taskId': widget.taskId,
                              'title': widget.title,
                              'body': widget.description,
                              'desc': widget.description,
                              'dueDate': parsedDateTime.toIso8601String(),
                            }),
                          );
                          setState(() {
                            tempShId = notiId;
                            notiId++;
                          });
                          print('tempShId : $tempShId');
                          _notiBtn = true;

                          var snackdemo = SnackBar(
                            content: Text(
                                'Notification Scheduled for ${widget.title}'),
                            backgroundColor: Colors.blueAccent,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                          return;
                        }

                        if (_notiBtn && isFuture) {
                          print('_notiBtn : $_notiBtn');
                          print('isFuture : $isFuture');
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Cancel notification for'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('the task '),
                                      Text(
                                        widget.title,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    onPressed: () {
                                      notificationService
                                          .cancelScheduledNotification(
                                              tempShId);
                                      setState(() {
                                        _notiBtn = false;
                                      });
                                      Navigator.pop(context);
                                      var snackdemo = SnackBar(
                                        content: Text('Notification cancelled'),
                                        backgroundColor: Colors.blueAccent,
                                        elevation: 10,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(5),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackdemo);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      icon: Icon(
                        Icons.snooze_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        !_notiBtn && isFuture ? 'Notify Alert' : 'Cancel Alert',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  width: 150.0,
                  color: Colors.redAccent,
                  child: TextButton.icon(
                      // style: Colors.blue,
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Are you sure to delete'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('the task '),
                                    Text(
                                      widget.title,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).pop();
                                    deleteTask(context, widget.taskId);
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
