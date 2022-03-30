import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/UI/pages/notification_screen.dart';
import 'package:todo/UI/size_config.dart';
import 'package:todo/UI/widgets/button.dart';
import 'package:todo/UI/widgets/input_field.dart';
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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
              Get.to(const NotificationScreen(
                  payload: 'Oussama;dfjjfdjf;dfjdfjdfjfd;10:10'));
            },
            icon:  Icon(Icons.wb_sunny_outlined,color: Get.isDarkMode?Colors.white:Colors.black,)),
      ),
      body:  Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                
              MyButton(label: 'Add Task', onPressed: (){}),
              const InputField(title: 'Title', hint: 'enter you name ')
            ],
          ),
        ),
      )
    );
  }
}
