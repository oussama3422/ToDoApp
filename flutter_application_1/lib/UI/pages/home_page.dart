// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../../models/task.dart';
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
  late NotifyHelper notifyhelper;
  @override
  void initState() {
    notifyhelper = NotifyHelper();
    notifyhelper.initialization();
    super.initState();
  }

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
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
          // NotifyHelper().scheduleNotifaction();
          // NotifyHelper().showBigPictureNotification();
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
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (ctx, index) {
          var task = _taskController.taskList[index];
          var hour = task.startTime.toString().split(';'[0]);
          var minutes = task.startTime.toString().split(';'[0]);

          var date = DateFormat.jm().parse(task.startTime!);
          var myTime = DateFormat('HH:mm').format(date);

          notifyhelper.scheduleNotifaction(
            int.parse(myTime.toString().split(';')[0]),
            int.parse(myTime.toString().split(';')[1]),
            task
            );

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 1375),
            child: SlideAnimation(
              horizontalOffset: 200,
              child: FadeInAnimation(
                duration: Duration(milliseconds: 300),
                delay: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    _showBottomSheet(
                      context,
                      task,
                    );
                  },
                  child: TaskTile(task),
                ),
              ),
            ),
          );
        },
        itemCount: _taskController.taskList.length,
      ),
    );
    // return Expanded(
    //     child: GestureDetector(
    //   onTap: () {
    //     _showBottomSheet(
    //       context,
    //       Task(
    //         title: 'Title 1',
    //         note: 'Note Somthing',
    //         isCompleted: 0,
    //         startTime: '16:05',
    //         endTime: '16:10',
    //         color: 1,
    //       ),
    //     );
    //   },
    //   child: TaskTile(Task(
    //     title: 'Title 1',
    //     note: 'Note Somthing',
    //     isCompleted: 0,
    //     startTime: '16:05',
    //     endTime: '16:10',
    //     color: 1,
    //   )),
    // )
    //     // child: Obx(
    //     //   () => _taskController.taskList.isEmpty
    //     //       ? _noTaskMsg()
    //     //       : Container(height: 0),
    //     // ),
    //     );
  }

  _noTaskMsg() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: SizeConfig.orientation == Orientation.landscape
                ? Axis.vertical
                : Axis.horizontal,
            children: [
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(height: 6)
                  : SizedBox(height: 200),
              SvgPicture.asset(
                'images/task.svg',
                height: 200,
                semanticsLabel: 'Tasks',
                color: primaryClr.withOpacity(0.5),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You Dont have any Tasks Yet.To Make Youre Day More Productive..',
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
            ),
            const SizedBox(height: 20),
            task.isCompleted == 1
                ? Container()
                : _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      setState(() {
                        task.isCompleted = 1;
                      });
                      Get.back();
                    },
                    color: primaryClr,
                  ),
            _buildBottomSheet(
              label: 'Delete Task',
              onTap: () {
                Get.back();
              },
              color: primaryClr,
            ),
            Divider(color: Colors.orange),
            _buildBottomSheet(
              label: 'Cancel',
              onTap: () {
                Get.back();
              },
              color: primaryClr,
            ),
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color color,
      bool isClose = false}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          height: 65,
          width: SizeConfig.screenWidth * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : color),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : color,
          ),
          child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white)),
          ),
        ));
  }
}
