import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
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
                widget: IconButton(
                  icon: const Icon(Icons.calendar_month_sharp),
                  onPressed: () => _getDateFromUser(),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(Icons.alarm_rounded),
                        onPressed: () => _getTimeFromUser(isStratTime: true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(Icons.alarm_rounded),
                        onPressed: () => _getTimeFromUser(isStratTime: false),
                      ),
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
                      onPressed: () =>_validateDate(),
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
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
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

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDataBase();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'It\'s required To Fill The Filed',
        messageText: const Text('It\'s required To Fill The Filed'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[600],
        snackStyle: SnackStyle.FLOATING,
        colorText: pinkClr,
        icon: const Icon(Icons.warning),
      );
    } else {
      print(
          '###############SOMETHING WENT WRONG##################################');
    }
  }

  _addTaskToDataBase() async {
    int value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      note: _noteController.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(_selectedTime),
      startTime: _startTime,
      endTime: _endTime,
      color: selectedColor,
      remind: _selectedRemind,
      repeat: _selectedRepaet,
    ));
    print(value);
  }

  _getTimeFromUser({bool? isStratTime}) async{
       TimeOfDay? _pickedTime = await showTimePicker(
         initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isStratTime!? TimeOfDay.fromDateTime(DateTime.now()):TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15),),),);
    if (isStratTime) {
      setState(() {
        _startTime = _pickedTime!.format(context);
      });
    } 
    else if(!isStratTime) 
    {
       setState(() {
        _endTime = _pickedTime!.format(context);
      });
    }
    else {
      print('Somthing Went Wrong With null ');
    }
  }
  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedTime,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (_pickedDate != null) {
      setState(() {
        _selectedTime = _pickedDate;
      });
    } else {
      print('Somthing Went Wrong With null ');
    }
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
