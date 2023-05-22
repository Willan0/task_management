import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/constant/color.dart';
import 'package:task_management/constant/dimen.dart';
import 'package:task_management/controller/task_controller.dart';
import 'package:task_management/data/vos/task_vo.dart';
import 'package:task_management/util/extension.dart';
import 'package:task_management/widgets/easy_icon.dart';
import 'package:task_management/widgets/easy_text.dart';
import 'package:task_management/widgets/reusable_task_view.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now());
  String _endTime = '9:01 AM';
  int _selectReminder = 5;
  final List<int> _reminderList = [5, 10, 15, 20];
  String _selectRepeat = 'None';
  final List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedIndex = 0;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void dispose() {
    _noteEditingController.dispose();
    _titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: EasyIcon(
            icon: Icons.chevron_left,
            onPressed: () {
              Get.back();
            },
            isClick: true,
            size: kFi30x,
            color: Get.isDarkMode ? whiteColor : darkColor,
          ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMp10x, vertical: kMp10x),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyText(
                  text: 'Add Task',
                  fontSize: kFi25x,
                  fontWeight: FontWeight.w600,
                  fontColor: Get.isDarkMode ? whiteColor : darkColor,
                ),
                const SizedBox(
                  height: kMp10x,
                ),
                ResualbeTaskView(
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Title is Empty';
                    }
                    return null;
                  },
                  lable: 'Title',
                  hintText: 'Enter title here',
                  textEditingController: _titleEditingController,
                ),
                ResualbeTaskView(
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Title is Empty';
                    }
                    return null;
                  },
                  lable: 'Note',
                  hintText: 'Enter note here',
                  textEditingController: _noteEditingController,
                ),
                ResualbeTaskView(
                  validate: ((value) {}),
                  lable: 'Date',
                  hintText: DateFormat.yMd().format(_selectedDate),
                  widget: EasyIcon(
                    icon: Icons.calendar_month_outlined,
                    onPressed: () {
                      _getUserDate();
                    },
                    isClick: true,
                    size: kFi20x,
                    color: Get.isDarkMode ? greySecondColor : greyColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: ResualbeTaskView(
                      validate: ((value) {}),
                      hintText: _startTime,
                      lable: 'Start Time',
                      widget: EasyIcon(
                        color: Get.isDarkMode ? greySecondColor : greyColor,
                        icon: Icons.access_time_outlined,
                        onPressed: () {
                          _getUserTime(true);
                        },
                        isClick: true,
                      ),
                    )),
                    const SizedBox(
                      width: kMp10x,
                    ),
                    Expanded(
                        child: ResualbeTaskView(
                      validate: ((value) {}),
                      hintText: _endTime,
                      lable: 'End Time',
                      widget: EasyIcon(
                        icon: Icons.access_time_outlined,
                        color: Get.isDarkMode ? greySecondColor : greyColor,
                        onPressed: () {
                          _getUserTime(false);
                        },
                        isClick: true,
                      ),
                    ))
                  ],
                ),
                ResualbeTaskView(
                  validate: ((value) {}),
                  lable: 'Reminder',
                  hintText: '$_selectReminder minutes early',
                  widget: DropdownButton(
                    underline: const SizedBox(
                      height: 0,
                    ),
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          _selectReminder = int.parse(value ?? '');
                        });
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _reminderList
                        .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem(
                                  value: value.toString(),
                                  child: Text(value.toString()),
                                ))
                        .toList(),
                  ),
                ),
                ResualbeTaskView(
                  validate: ((value) {}),
                  lable: 'Repeat',
                  hintText: _selectRepeat,
                  widget: DropdownButton(
                    underline: const SizedBox(
                      height: 0,
                    ),
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          _selectRepeat = value ?? '';
                        });
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _repeatList
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem(
                                  value: value.toString(),
                                  child: Text(value.toString()),
                                ))
                        .toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPallete(),
                    MaterialButton(
                      minWidth: kWh120x,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kRi10x))),
                      height: kWh50x,
                      color: Get.isDarkMode ? greyColor : bluishColor,
                      onPressed: () => _validate(),
                      child: const EasyText(
                        text: 'Create Task',
                        fontSize: kFi18x,
                        fontColor: whiteColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validate() {
    if (_globalKey.currentState?.validate() ?? false) {
      _addToDataBase();
      _taskController.getTasks();
      Get.back();
    } else {
      context.showSnackBar('Requirement', 'You need to fill requirement');
    }
  }

  _addToDataBase() async {
    await _taskController.addTask(TaskVO(
        note: _noteEditingController.text,
        title: _titleEditingController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectReminder,
        repeat: _selectRepeat,
        color: _selectedIndex,
        isCompleted: 0));
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EasyText(
          text: 'Color',
          fontColor: Get.isDarkMode ? whiteColor : darkColor,
          fontSize: kFi18x,
        ),
        const SizedBox(
          height: kMp10x,
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: kMp10x),
                      child: CircleAvatar(
                        radius: kFi15x,
                        backgroundColor: index == 0
                            ? bluishColor
                            : index == 1
                                ? pinkColor
                                : yellowColor,
                        child: index == _selectedIndex
                            ? const Icon(
                                Icons.done,
                                color: whiteColor,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  _getUserDate() async {
    DateTime? pickerDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2250));
    if (pickerDateTime != null) {
      if (mounted) {
        setState(() {
          _selectedDate = pickerDateTime;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      context.showSnackBar('Error', 'Date error occour');
    }
  }

  _getUserTime(bool isStart) async {
    var pickedTime = await _getPickedTime();
    // ignore: use_build_context_synchronously
    var formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      // ignore: use_build_context_synchronously
      context.showSnackBar('Error', 'Date error occour');
    } else if (isStart == true) {
      if (mounted) {
        setState(() {
          _startTime = formattedTime;
        });
      }
    } else if (isStart == false) {
      if (mounted) {
        setState(() {
          _endTime = formattedTime;
        });
      }
    }
  }

  _getPickedTime() {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
