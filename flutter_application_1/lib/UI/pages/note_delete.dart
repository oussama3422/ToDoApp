
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:todo/models/task.dart';
// import 'package:todo/services/notification_services.dart';

// import '../../controllers/task_controller.dart';


class NoteDelete extends StatelessWidget {
   const NoteDelete({ Key? key }) : super(key: key);
  // var notifyHelper= NotifyHelper() ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.isDarkMode?Colors.grey:Colors.white,
      title:  Text('Warning',style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black)),
      content:Text('Are you sure you Want to delete this note ?',style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black)),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child:  Text('Yes',style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black)),
          ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop(false);
           

          },
          child:  Text('No',style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black)),
          ),
      ],
    );
  }
}