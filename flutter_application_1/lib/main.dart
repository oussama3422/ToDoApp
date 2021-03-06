import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/theme.dart';
import 'package:todo/services/theme_services.dart';

import 'UI/pages/home_page.dart';
// import 'ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      // home: const NotificationScreen(payload: 'Oussama;It time to Leave;You Have to check is which one do you want;12:31'),
      home: const HomePage(),
    );
  }
}
