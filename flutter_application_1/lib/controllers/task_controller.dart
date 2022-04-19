import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

// :::::::::::::::::::::This Function It Turn Is Add Data To DataBase::::::::::::::::::::
  addTask({required Task task}) {
    return DBHelper.insert(task);
  }

// :::::::::::::::::::::This Function It Turn Is get Task From To DataBase::::::::::::::::::::
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> task = await DBHelper.query();
    taskList.assignAll(task.map((tasksData) => Task.fromJson(tasksData)).toList());
  }

// :::::::::::::::::::::This Function It Use to Delete Task From DataBase::::::::::
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }
// :::::::::::::::::::::This Function It Use to Mark Up To Us That Task Is Completed::::::::::
  void markTaskAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
