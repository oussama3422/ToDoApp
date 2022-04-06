import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initialization() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mypic');
    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (String? payload) async {
      onSelectNotification(payload!);
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notifaction Payload : $payload');
    }

    await Get.to(NotificationScreen(payload: payload));
  }

  // schedule Notification — used to perform a scheduled task and implemented notification occurs at a specific time.
  Future<void> displayNotifcation(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'new Reminder',
      'Oussama',
      'Hello bro',
      // icon: 'mypic',
      priority: Priority.high,
      importance: Importance.max,
      enableLights: true,
      color: Colors.blue,
      showWhen: false,
      styleInformation: MediaStyleInformation(),
      largeIcon: DrawableResourceAndroidBitmap('mypic'),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default-Sounds',
    );
  }

  scheduleNotifaction(int hour, int minute, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'title',
      'body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'channelId', 'channelName', 'channelDescription')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('mypic'),
        largeIcon: DrawableResourceAndroidBitmap('mypic'),
        contentTitle: 'flutter devs',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

// ::::::::::Cancel Notification Remove The Notification of the given Id
  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
