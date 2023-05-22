import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import '../controller/task_controller.dart';
import '../data/vos/task_vo.dart';
import 'easy_button.dart';
import 'easy_text.dart';

class TaskTile extends StatelessWidget {
  final TaskVO? task;
  final TaskController taskController;
  const TaskTile(this.task, this.taskController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kMp10x),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: kMp10x, top: kMp10x),
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(context, task);
        },
        child: Container(
          padding: const EdgeInsets.all(kMp10x),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRi16x),
            color: _getBGClr(task?.color ?? 0),
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyText(
                      text: task?.title ?? "",
                      fontSize: kFi15x,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.white),
                  const SizedBox(
                    height: kWh12x,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: kFi18x,
                      ),
                      const SizedBox(width: kMp5x),
                      EasyText(
                        text: "${task!.startTime} - ${task!.endTime}",
                      ),
                    ],
                  ),
                  const SizedBox(height: kWh12x),
                  EasyText(
                    text: task?.note ?? "",
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kMp20x),
              height: kWh60x,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: EasyText(
                  text: task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                  fontSize: kFi10x,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, TaskVO? task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.symmetric(horizontal: kMp20x),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kRi20x),
              topRight: Radius.circular(kRi20x)),
          color: Get.isDarkMode ? darkColor : whiteColor),
      height: task?.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: kWh120x,
            height: kWh7x,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? greyColor : greySecondColor,
                borderRadius: const BorderRadius.all(Radius.circular(kRi7x))),
          ),
          const SizedBox(
            height: kWh60x,
          ),
          task?.isCompleted == 1
              ? const SizedBox()
              : EasyButton(
            width: MediaQuery.of(context).size.width,
            labelColor: whiteColor,
            onPressed: () {
              taskController.markAsCompleted(task?.id ?? 0);
              Get.back();
            },
            label: 'Task Completed',
            color: bluishColor,
          ),
          const SizedBox(
            height: kMp10x,
          ),
          EasyButton(
            width: MediaQuery.of(context).size.width,
            labelColor: whiteColor,
            onPressed: () {
              taskController.delete(task?.id ?? 1);
              Get.back();
            },
            label: 'Delete Task',
            color: pinkColor,
          ),
          const SizedBox(
            height: kMp20x,
          ),
          EasyButton(
            labelColor: Get.isDarkMode ? whiteColor : darkColor,
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              Get.back();
            },
            label: 'Close',
            color: Get.isDarkMode ? greyColor : whiteColor,
          )
        ],
      ),
    ));
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowColor;
      default:
        return bluishColor;
    }
  }
}