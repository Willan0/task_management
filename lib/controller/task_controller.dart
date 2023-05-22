import 'package:get/get.dart';
import 'package:task_management/data/vos/task_vo.dart';
import 'package:task_management/database/database_helper.dart';

class TaskController extends GetxController {
  var taskList = <TaskVO>[].obs;
  Future<int> addTask(TaskVO taskVO) async {

    return await DatabaseHelper.insertData(taskVO);
  }

  void getTasks() async {
    List<Map<String, dynamic>> task = await DatabaseHelper.query();
    taskList.assignAll(task.map((data) => TaskVO.fromJson(data)).toList());
  }

  void delete(int id) async {
    await DatabaseHelper.deleteData(id);
    getTasks();
  }

  void markAsCompleted(int id) async {
    await DatabaseHelper.updateData(id);
    getTasks();
  }
}
