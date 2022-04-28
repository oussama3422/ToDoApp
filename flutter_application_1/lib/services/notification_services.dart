import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

    await Get.to(()=>NotificationScreen(payload: payload));
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
      _nextInstanceOftenAM(hour, minutes,task.remind!,task.repeat!,task.date!),
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
  tz.TZDateTime _nextInstanceOftenAM(int hour, int minutes,int remind,String repeat,String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print('Now = $now');
     var formateddate =DateFormat.yMd().parse(date);
     final tz.TZDateTime formateddate2 = tz.TZDateTime.from(formateddate,tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, formateddate2.year, formateddate2.month, formateddate2.day, hour, minutes);
    print('Choosen Date : $scheduleDate');
    scheduleDate = afterRemind(remind, scheduleDate);

    if (scheduleDate.isBefore(now)) {
    if(repeat=='Daily'){
     scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, (formateddate.day)+1, hour, minutes);
    }
    if(repeat=='Weekly'){
     scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, (formateddate.day)+7, hour, minutes);
    }
    if(repeat=='Monthly'){
      scheduleDate = tz.TZDateTime(tz.local, now.year, (formateddate.month)+1,formateddate.day, hour, minutes);
    }
    scheduleDate = afterRemind(remind, scheduleDate);
    }
    
   
    print('Next ScheduleDate  = $scheduleDate');
    return scheduleDate;
  }
// :::::::::::::::::::::::After Remind Method::::::::::::::::::://
  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduleDate) {
      if(remind==5){
      scheduleDate=scheduleDate = scheduleDate.subtract(const Duration(minutes: 5));
    }
    if(remind==10){
      scheduleDate=scheduleDate = scheduleDate.subtract(const Duration(minutes: 10));
    }
    if(remind==15){
      scheduleDate=scheduleDate = scheduleDate.subtract(const Duration(minutes: 15));
    }
    if(remind==20){
      scheduleDate=scheduleDate = scheduleDate.subtract(const Duration(minutes: 20));
    }
    return scheduleDate;
  }

// :::::::::::::::::::::::::This Method Show to Big Notifiction::::::::::::::::::::::::
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

// ::::::::::Cancel Notification Method Remove The Notification of Id the given :::::::::::
  Future<void> cancelNotification(Task tsk) async {




    await flutterLocalNotificationsPlugin.cancel(tsk.id!);
  }
// ::::::::::Cancel All Notification Method ::::::::::::::::::://
  Future<void> cancelALLNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
