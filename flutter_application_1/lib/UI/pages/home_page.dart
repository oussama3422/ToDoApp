// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/ui/pages/add_task_page.dart';
import '/ui/size_config.dart';
import '/ui/theme.dart';
import '/ui/widgets/button.dart';
import '/services/theme_services.dart';
import '/ui/theme.dart';
import '../../controllers/task_controller.dart';
import '../../services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDataBar(),
            const SizedBox(height: 6),
            _showTasks(),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
          size: 24,
        ),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: true,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/mypic.jpeg'),
          radius: 18,
        ),
        SizedBox(width: 15),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subheadingStyle),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
              label: 'Add Task',
              onPressed: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _addDataBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedTime,
        height: 100,
        width: 65,
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        onDateChange: (newdate) {
          _selectedTime = newdate;
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child:_noTaskMsg()
      // child: Obx(
      //   () => _taskController.taskList.isEmpty
      //       ? _noTaskMsg()
      //       : Container(height: 0),
      // ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment:WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction:  SizeConfig.orientation == Orientation.landscape?Axis.horizontal:Axis.vertical,
            children:  [
              SizeConfig.orientation == Orientation.landscape?
              const SizedBox(height: 6)
              :
              SizedBox(height:220),
              SvgPicture.asset(
                'images/task.svg',
                 height: 150,
                 semanticsLabel: 'Tasks',
                 color: primaryClr.withOpacity(0.5),
                ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'You Dont have any Tasks Yet.To Make Youre Day More Productive..',
                  style: headingStyle,
                  textAlign:TextAlign.center,
                  ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
