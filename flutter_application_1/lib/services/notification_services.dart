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
    // if (payload != null) {
    //   debugPrint('Notifaction Payload : $payload');
    // }

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
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mypic');
    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (String? payload) async {
      onSelectNotification(payload!);
    });
  }

  scheduleNotifaction(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title!,
      task.note!,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOftenAM(hour, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId', 'channelName', 'channelDescription'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: '${task.title};${task.note};${task.startTime}',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ::::::::::::::::::;We Make Next Instance Of Ten AM::::::::::::::::
  tz.TZDateTime _nextInstanceOftenAM(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
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
        payload: 'big image notifications');
  }

// ::::::::::Cancel Notification Remove The Notification of the given Id
  Future<void> cancelNotification(Task tsk) async {
    await flutterLocalNotificationsPlugin.cancel(tsk.id!);
  }
}
