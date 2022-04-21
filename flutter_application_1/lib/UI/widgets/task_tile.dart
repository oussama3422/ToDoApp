import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task,{Key? key}) : super(key: key);

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),  
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth! / 2
          : SizeConfig.screenWidth,
      child: Container(
        height:130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: getBackGroundColor(task.color),
        ),
        child: Row(
         
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Title :${task.title!}',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${task.startTime}',
                           style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white,
                              ),
                           ),
                        ),
                        const SizedBox(width: 5),
                         Text(
                           '-', 
                           style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                           ),
                           ),
                        const SizedBox(width: 5),
                        Text(
                          '${task.endTime}',
                           style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                             ),
                            ),
                         ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Text(
                     'Note : ${task.note!}',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 0.5,
              height: 60,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            const Divider(color: Colors.white,height: 20,),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'COMPLETED',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBackGroundColor(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
