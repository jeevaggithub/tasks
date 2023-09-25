import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasks/services/noti_service.dart';

class NotiTaskScreen extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final String dueDate;
  final NotificationService notificationService = NotificationService();

  NotiTaskScreen({
    Key? key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<NotiTaskScreen> {
  late NotificationService notificationService;

  final String taskId = '';
  final String title = '';
  final String descrption = '';
  final String dueDate = '';

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService();
    notificationService.initNotification();
  }

  bool _notiBtn = false;
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    print(' Message printing from notiTaskScreen: $message');
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
                  'Task Description : ',
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
                  color: Colors.blue,
                  child: TextButton.icon(
                      // style: Colors.blue,
                      onPressed: () {
                        setState(() {
                          _notiBtn = !_notiBtn;
                          print(_notiBtn);
                        });

                        // Snooze  notification when "Snooze Alert" button is clicked
                      },
                      icon: Icon(
                        Icons.snooze_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        // !_notiBtn ? 'Notify Alert' : 'Cancel Alert',
                        'Snooze alert',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  width: 150.0,
                  color: Colors.redAccent,
                  child: TextButton.icon(
                      // style: Colors.blue,
                      onPressed: () {},
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
