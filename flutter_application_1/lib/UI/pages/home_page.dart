// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/UI/widgets/task_tile.dart';
import 'package:todo/services/notification_services.dart';
// import 'package:todo/UI/widgets/task_tile.dart';
import '../../models/task.dart';
import '/UI/pages/add_task_page.dart';
import '/UI/size_config.dart';
import '/UI/theme.dart';
import '/UI/widgets/button.dart';
import '/services/theme_services.dart';
// import '/UI/theme.dart';
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
          showTasks(),
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
              Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subheadingStyle),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            icon: Icon(Icons.add_task_sharp),
              label: 'Add Task',
              onPressed: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }
              ),
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

    showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh:onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.taskList[index];

// :::::::::::::::we check if they TodoList Diallt Or Not::::::::::::::::::::::::::::::
                // final timeformated=DateFormat.yMd().parse(task.date!);

                if ((task.repeat == 'Daily' 
                        ||
                        task.date ==  DateFormat.yMd().format(_selectedTime))
                        || 
                        (task.repeat=='Weeklly' && _selectedTime.difference(DateFormat.yMd().parse(task.date!)).inDays %7==0) 
                        ||
                        (task.repeat=='Monthly' && DateFormat.yMd().parse(task.date!).day == _selectedTime.day  ))
                {
                  try{
                  var hours = task.startTime.toString().split(':')[0];
                  var minutes = task.startTime.toString().split(':')[1];

                  debugPrint('My time is ' + hours);
                  debugPrint('My Minutes is ' + minutes);

                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('hh:mm a').format(date);

                  notifyhelper.scheduleNotifaction(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[0]),
                    _taskController.taskList[index],
                  );
                  }catch(e){
                    print(e);
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1373),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
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
                }  else {
                  return Container();
                }
              },
              itemCount: _taskController.taskList.length,
            ),
          );
        }
      }),
    );
  
    
  }

  _noTaskMsg() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                SizeConfig.orientation == Orientation.landscape ? const SizedBox(height: 6) : SizedBox(height: 200),
                Image.asset('images/ToDoTask.png', height: 200,color: primaryClr.withOpacity(0.7),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You dont have any tasks Yet !!',
                    style: headingStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
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
          width: SizeConfig.screenWidth! * 0.9,
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

  Future<void> onRefresh() async{
    return _taskController.getTasks();
  }
  }

