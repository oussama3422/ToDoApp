import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/ui/widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedTime = DateTime.now();
  String _startTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm:a')
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .toString();

  int _selectedRemind = 5;
  var remindList = [5, 10, 15, 20];
  String _selectedRepaet = 'None As Default';
  var repeatList = ['None As Default', 'Daily', 'Weekly', 'Monthly'];

  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Task ', style: headingStyle),
              InputField(
                title: 'Title',
                hint: 'enter youre name ',
                controller: _titleController,
              ),
              const SizedBox(height: 2),
              InputField(
                title: 'Note',
                hint: 'enter youre Note ',
                controller: _noteController,
              ),
              const SizedBox(height: 2),
              InputField(
                title: 'Date',
                hint: DateFormat('dd/MM/yyy').format(DateTime.now()),
                widget: const Icon(Icons.calendar_month),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: const Icon(Icons.alarm_rounded),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: const Icon(Icons.alarm_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind Minutes early',
                widget: DropdownButton(
                    items: remindList.map((val) {
                      return DropdownMenuItem(
                        child: Text('$val'),
                        value: val,
                      );
                    }).toList(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(height: 0),
                    style: subheadingStyle,
                    onChanged: (int? newval) {
                      setState(() {
                        _selectedRemind = newval!;
                      });
                    }),
              ),
              const SizedBox(height: 2),
              InputField(
                title: 'Repeat',
                hint: _selectedRepaet,
                widget: DropdownButton(
                    items: repeatList.map((val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    }).toList(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(height: 0),
                    style: subheadingStyle,
                    onChanged: (String? newval) {
                      setState(() {
                        _selectedRepaet = newval!;
                      });
                    }),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  colorPallete(),
                  MyButton(
                    label: 'Add Task',
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // this background of AppBar
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
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

  colorPallete() {
    return Column(
      children: [
        Text(
          'Color',
          style: subheadingStyle,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    minRadius: 15,
                    child:
                        selectedColor == index ? const Icon(Icons.done) : null,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr),
              ),
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
