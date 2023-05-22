import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constant/color.dart';

extension Extension on BuildContext {
  void pushScreen(context, widget) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  showSnackBar(title, message) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Get.isDarkMode?whiteColor:greyColor,
        icon: const Icon(Icons.warning_rounded),
        backgroundColor: Get.isDarkMode ? greySecondColor : whiteColor);
  }
}
