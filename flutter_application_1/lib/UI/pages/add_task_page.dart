import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import'package:todo/ui/theme.dart';
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
      .format(DateTime.now().add(Duration(minutes: 10)))
      .toString();

  int _selectedRemind = 5;
  var remindList = [5, 10, 15, 20];
  String _selectedRepaet = 'None As Default';
  var repeatList = ['None As Default', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              const SizedBox(height: 10),
              InputField(
                title: 'Note',
                hint: 'enter youre Note ',
                controller: _noteController,
              ),
              const SizedBox(height: 10),
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
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: const Icon(Icons.alarm_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                    style:subheadingStyle,
                    onChanged: (int? newval) {
                      setState(() {
                        _selectedRemind  = newval!;
                      });
                    }),
              ),
              const SizedBox(height: 10),
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
                    style:subheadingStyle,
                    onChanged: (String? newval) {
                      setState(() {
                        _selectedRepaet  = newval!;
                      });
                    }),
              ),
            const SizedBox(height: 20),
            Align(
              alignment: const Alignment(1,9),
              child: MyButton(
                label: 'Add Task',
                onPressed: (){},
                ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
