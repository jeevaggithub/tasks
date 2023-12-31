import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasks/screens/Noti_taskScreen.dart';
// import 'package:tasks/screens/task_screen.dart';

import '../main.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final BuildContext context; // Add a context parameter

  // NotificationService(this.context);

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('task_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var intializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(intializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print('notification(${notificationResponse.id}) action tapped: '
          '${notificationResponse.actionId} with'
          ' payload: ${notificationResponse.payload}');

      final payload = notificationResponse.payload;
      if (payload != null) {
        final notificationPayload = jsonDecode(payload);

        final taskId = notificationPayload['taskId'];
        final title = notificationPayload['title'];
        final desc = notificationPayload['desc'];
        final dueDate = notificationPayload['dueDate'];
        final body = notificationPayload['body'];
        print('printing noti values ');
        print('taskId : $taskId');
        print('title : $title');
        print('desc : $desc');
        print('dueDate : $dueDate');
        print('body : $body');

        if (taskId != null) {
          await navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (BuildContext context) => NotiTaskScreen(
                taskId: taskId,
                title: title,
                description: desc,
                dueDate: dueDate,
              ),
            ),
          );
        }
      }
    });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      String? taskId,
      String? desc,
      String? dueDate}) async {
    final notificationPayload = {
      'taskId': taskId,
      'title': title,
      'body': body,
      'desc': desc,
      'dueDate': dueDate
    };
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails(),
        payload: jsonEncode(notificationPayload));
  }

  // Future<void> scheduleNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? taskId,
  //   String? desc,
  //   DateTime? dueDate,
  // }) async {
  //   if (dueDate != null) {
  //     final notificationTime = dueDate.subtract(Duration(minutes: 10));
  //     final now = DateTime.now();
  //     if (notificationTime.isAfter(now)) {
  //       await flutterLocalNotificationsPlugin.zonedSchedule(
  //         id,
  //         title,
  //         body,
  //         tz.TZDateTime.from(notificationTime, tz.local),
  //         await notificationDetails(),
  //         androidAllowWhileIdle: true,
  //         uiLocalNotificationDateInterpretation:
  //             UILocalNotificationDateInterpretation.absoluteTime,
  //         payload: jsonEncode({
  //           'taskId': taskId,
  //           'title': title,
  //           'body': body,
  //           'desc': desc,
  //           'dueDate': dueDate.toIso8601String(),
  //         }),
  //       );
  //     }
  //   }
  // }

  Future scheduleNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    String? taskId,
    String? desc,
    required DateTime? dueDate,
  }) async {
    print('printing from scheduleNotification :${dueDate.toString()}');
    return flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dueDate!, tz.local),
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> cancelScheduledNotification(id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
