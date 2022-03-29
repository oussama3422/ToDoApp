import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/pages/notification_screen.dart';
import 'package:todo/UI/widgets/button.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/services/theme_services.dart';

import '../../services/theme_services.dart';
import '../../services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
              Get.to(const NotificationScreen(payload: 'Oussama;dfjjfdjf;dfjdfjdfjfd;10:10')                  );
            },
            icon: const Icon(Icons.wb_sunny_outlined)),
      ),
      body: Center(child: MyButton(label: 'Click', onPressed: (){})),
    );
  }
}
