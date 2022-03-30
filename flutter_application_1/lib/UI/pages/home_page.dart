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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedTime = DateTime.now();
  String _startTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const InputField(
                  title: 'Title',
                  hint: 'enter you name ',
                ),
                SizedBox(height: 10),
                const InputField(
                  title: 'Note',
                  hint: 'enter youre Note That You want to Save it. ',
                ),
                const SizedBox(height: 10),
                InputField(
                  title: 'Date',
                  hint: DateFormat('hh:mm:a').format(DateTime.now()).toString(),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_month_sharp,
                        size: 30,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {},
                  ),
                ),
                InputField(
                  title: 'Start Time',
                  hint: '',
                ),
                InputField(
                  title: 'End Time',
                  hint: '',
                ),
                InputField(
                  title: 'Remind',
                  hint: '',
                ),
                InputField(
                  title: 'Repeat',
                  hint: '',
                ),
                MyButton(label: 'Add Task', onPressed: () {})
              ],
            ),
          ),
        ));
  }
}
