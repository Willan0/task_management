import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:task_management/constant/color.dart';
import 'package:get/get.dart';
import 'package:task_management/constant/dimen.dart';
import 'package:task_management/controller/task_controller.dart';
import 'package:task_management/page/task_page.dart';
import 'package:task_management/widgets/easy_icon.dart';
import 'package:task_management/widgets/easy_text.dart';

import '../data/vos/task_vo.dart';
import '../services/notification_service.dart';
import '../services/theme_service.dart';
import '../widgets/custom_task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectDate = DateTime.now();
  final taskController = Get.put(TaskController());

  NotifyService notifyHelper = NotifyService();
  @override
  void initState() {
    taskController.getTasks();
    notifyHelper.initializeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        title: EasyText(
          fontSize: kFi20x,
          fontWeight: FontWeight.w600,
          text: 'Task',
          fontColor: Get.isDarkMode ? whiteColor : darkColor,
        ),
        leading: EasyIcon(
            size: kFi25x,
            isClick: true,
            color: Get.isDarkMode ? whiteColor : darkColor,
            onPressed: () {
              ThemeDAO().switchTheme();
              notifyHelper.displayNotification(
                  title: 'Theme Change',
                  body: Get.isDarkMode
                      ? 'Activate Light Theme'
                      : 'Activate Dark Theme');
            },
            icon: Get.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.nightlight_round_outlined),
        actions: const [
          CircleAvatar(
            radius: kRi20x,
            backgroundImage: AssetImage('images/profile.jpg'),
          ),
          SizedBox(
            width: kMp10x,
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_addTaskBar(), _datePickerView(), _taskView()],
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(kMp10x),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyText(
                text: DateFormat.yMMMMd().format(DateTime.now()),
                fontColor: Get.isDarkMode ? whiteColor : greyColor,
                fontSize: kFi20x,
              ),
              EasyText(
                text: 'Today',
                fontWeight: FontWeight.bold,
                fontColor: Get.isDarkMode ? whiteColor : darkColor,
                fontSize: kFi25x,
              )
            ],
          )),
          MaterialButton(
            color: Get.isDarkMode ? greyColor : bluishColor,
            minWidth: kWh120x,
            height: kWh50x,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRi10x))),
            onPressed: () async {
              await Get.to(() => const TaskPage());
            },
            child: Row(
              children: [
                EasyIcon(
                  icon: Icons.add,
                  onPressed: () {},
                  color: whiteColor,
                ),
                const SizedBox(
                  width: kMp10x,
                ),
                const EasyText(text: 'Add task')
              ],
            ),
          )
        ],
      ),
    );
  }

  _datePickerView() {
    return Padding(
      padding: const EdgeInsets.only(top: kMp20x, left: kMp10x),
      child: SizedBox(
        child: DatePicker(
          DateTime.now(),
          onDateChange: (selectedDate) {
            setState(() {
              selectDate = selectedDate;
            });
          },
          width: kWh80x,
          height: kWh100x,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: whiteColor,
          dateTextStyle: TextStyle(
            fontSize: kFi20x,
            color: Get.isDarkMode ? whiteColor : greyColor,
            fontWeight: FontWeight.w600,
          ),
          monthTextStyle: TextStyle(
            fontSize: kFi15x,
            color: Get.isDarkMode ? whiteColor : greyColor,
            fontWeight: FontWeight.w600,
          ),
          dayTextStyle: TextStyle(
            fontSize: kFi18x,
            color: Get.isDarkMode ? whiteColor : greyColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _taskView() {
    return Expanded(
        child: Obx(
      () => ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            TaskVO task = taskController.taskList[index];
            if (task.repeat == 'Daily') {
              DateTime dateTime = DateFormat.jm().parse(task.startTime ?? '');
              var taskTime = DateFormat('HH:mm').format(dateTime);
              notifyHelper.scheduledNotification(
                  int.parse(taskTime.split(':')[0]),
                  int.parse(taskTime.split(':')[1]),
                  task);
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: TaskTile(task, taskController),
                    ),
                  ));
            }
            if (task.date == DateFormat.yMd().format(selectDate)) {
              DateTime dateTime = DateFormat.jm().parse(task.startTime ?? '');
              var taskTime = DateFormat('HH:mm').format(dateTime);
              notifyHelper.scheduledNotification(
                  int.parse(taskTime.split(':')[0]),
                  int.parse(taskTime.split(':')[1]),
                  task);
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: TaskTile(task, taskController),
                    ),
                  ));
            }
            return const SizedBox();
          }),
    ));
  }
}
