// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/UI/pages/add_task_page.dart';
import 'package:todo/UI/pages/notification_screen.dart';
import 'package:todo/UI/size_config.dart';
import 'package:todo/UI/theme.dart';
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
        appBar: _appBar(),
        body: Container( 
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
                Center(child: MyButton(label: 'Add Task', onPressed: ()=>Get.to(AddTaskPage())))
              ],
            ),
          ),
        ));
  }
  
  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: true,
      actions: const [
         CircleAvatar(
          backgroundImage:  AssetImage('images/mypic.jpeg'),
          radius:18,
        ),
        SizedBox(width:15),
      ],
    );
  }
}
